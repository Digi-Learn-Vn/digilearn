# digilearn

```markdown
digilearn/
│
├── apps/
│   ├── flutter_app/            # Flutter mobile & web app
│   │   ├── lib/
│   │   ├── android/
│   │   ├── ios/
│   │   ├── web/
│   │   ├── pubspec.yaml
│   │   └── (etc.)
│   │
│   ├── backend_server/         # Backend server (Node.js, Django, Go, etc.)
│   │   ├── src/
│   │   ├── config/
│   │   ├── Dockerfile
│   │   ├── package.json / requirements.txt
│   │   └── (etc.)
│
├── packages/                   # Shared libraries/packages
│   ├── shared_ui/               # Flutter shared UI components (buttons, themes)
│   ├── shared_models/           # Dart models shared across app & API (optional)
│   ├── backend_lib/             # (optional) Common backend libs (auth utils, db handlers)
│
├── infrastructure/             # DevOps, deployment stuff
│   ├── docker/
│   ├── terraform/               # (optional) if using cloud infra
│   ├── scripts/                 # Shell scripts, db migrations
│
├── docs/                        # Documentation (for onboarding, API docs)
│
├── .gitignore
├── README.md
└── project_config.yaml          # Your own config if you automate builds/deploys
```

## Install Devtools

https://docs.flutter.dev/get-started/install/linux/web

## How to run

```
git submodule update --init --recursive
cd apps/flutter_app
flutter run -d web-server --web-port=8080
```

## Quick run
The project use script `deploy.py` for running the app

### Usage
There are 2 stages:
1. Build

At this stage, the front end flutter is compiled to web asset (html, css, javascript), then copy to `build` folder of backend app 

For easier integration, the `django` backend will serve the web asset. There is no need to run 2 separate servers (1 for deploy front end, 1 for backend).
Using 2 servers introduces many problems, such as CORS

Run command:
```
python deploy.py build
```

2. Run 

After building, the app is ready to serve. This command reset the backend to main branch (optional), setup environment, and run the server

Run command:
```
python deploy.py run
```

See `-h` for all available options. There are two options:
- `-p <PORT>`: Select the port to run server 
- `--force-reset`: Add this option to reset the backend git

### The `ALL` command
Alternatively, the script added `all` command that **build** and **run** the app. The command will **RESET** the backend and run app at port **8000**. 
For finer control, use the `build` and `run` command

```
python deploy.py all
```