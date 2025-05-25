import argparse
import os
import subprocess
import logging
import shutil

flutter_dir = os.path.join(os.path.dirname(__file__), "apps", "flutter_app")
backend_dir = os.path.join(os.path.dirname(__file__), "apps", "DigiLearnBackend")
backend_app_dir = os.path.join(backend_dir, "BackendApp")
frontend_output_dir = os.path.join(backend_app_dir, "build")

class Command:
    BUILD = "build"
    RUN = "run"
    ALL = "all"

class BaseHandler:
    def __init__(self):
        pass

    def setup_backend_folder(self):
        # Check if backend dir is empty
        if len(os.listdir(backend_dir)) == 0:
            print(f"Setting up backend at {backend_dir}")
            cmd = "git submodule update --init --recursive"
            subprocess.run(cmd, cwd=os.path.dirname(__file__), shell=True, check=True)

class BuildHandler(BaseHandler):
    def __init__(self):
        # unzip the variable here
        pass

    def handle(self):
        self.setup_backend_folder()
        flutter_output_dir = os.path.join(frontend_output_dir, "flutter")
        if not os.path.exists(flutter_output_dir):
            os.makedirs(flutter_output_dir)
        else:
            # clear old build file
            shutil.rmtree(flutter_output_dir)
            os.makedirs(flutter_output_dir)
    
        cmd = f"flutter build web --output {flutter_output_dir}"
        subprocess.run(cmd, cwd=flutter_dir, shell=True)

class RunHandler(BaseHandler):
    def __init__(self, reset_git : bool, port : int):
        # unzip the variable here
        self._is_reset_git = reset_git
        self._port = port

    def __reset_backend(self):
        # Stash the working dir
        print(f"Stashing working dir at {backend_dir}")
        cmd = "git stash"
        subprocess.run(cmd, shell=True, cwd=backend_dir, check=True)
        # checkout main branch and pull latest commit
        print(f"Updating {backend_dir}")
        cmd = "git submodule update --remote --recursive"
        subprocess.run(cmd, shell=True, cwd=backend_dir, check=True)

    def handle(self):
        self.setup_backend_folder()
        if self._is_reset_git:
            self.__reset_backend()
        # Sync then run
        print(f"Syncing environment at {backend_dir}")
        cmd = "uv sync"
        subprocess.run(cmd, shell=True, cwd=backend_dir, check=True)
    
        # Run server
        print("Starting server....")
        work_dir = os.path.join(backend_dir, "BackendApp")
        cmd = f"uv run --active manage.py makemigrations accounts"
        subprocess.run(cmd, shell=True, cwd=work_dir, check=True)
        cmd = f"uv run --active manage.py migrate"
        subprocess.run(cmd, shell=True, cwd=work_dir, check=True)
        cmd = f"uv run --active manage.py runserver {self._port}"
        subprocess.run(cmd, shell=True, cwd=work_dir, check=True)

def parse():
    parser = argparse.ArgumentParser(prog="Digilearn Deploy", 
                                     description="Automate setting up and serving front end and backend")
    
    subparser = parser.add_subparsers(help="Options to build and deploy", dest="command", required=True)
    
    build_parser = subparser.add_parser(name=Command.BUILD, help="Build the app")
    run_parser = subparser.add_parser(name=Command.RUN, 
                                      help="Setup backend and run app", 
                                      description=f"Setup the backend and run the app")
    run_parser.add_argument("-p", "--port", type=int, default=8000, help="Port to run server at. Default is 8000")
    run_parser.add_argument("--force-reset", dest="reset", action="store_true", help="Set this flag to reset the backend app to main branch")
    all_parser = subparser.add_parser(name=Command.ALL,
                                      help="Build front end, reset backend, run app",
                                      description="All in one for quick development: build front end, reset backend, run app at port 8000." \
                                          f"If you want more control, use command {Command.BUILD} and command {Command.RUN}")
    args = parser.parse_args()

    if args.command == Command.BUILD:
        handler = BuildHandler()
        handler.handle()
    elif args.command == Command.RUN:
        reset_git = args.reset
        port = args.port
        handler = RunHandler(reset_git, port)
        handler.handle()
    elif args.command == Command.ALL:
        reset_git = True
        port = 8000
        build_handler = BuildHandler()
        build_handler.handle()
        run_handler = RunHandler(reset_git, port)
        run_handler.handle()


if __name__ == '__main__':
    parse()