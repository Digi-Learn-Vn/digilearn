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
