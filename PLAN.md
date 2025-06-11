# Project Plan for ErgoMotion Lab

## Overview
This document outlines the planned tasks to build the ErgoMotion Lab application.
Each task corresponds to an orchestrator milestone. Estimated lines of code (LOC) refer to new or modified lines.

| Task | Description | Key Files | Est. LOC | Depends On |
| ---- | ----------- | --------- | ------- | ---------- |
| 0 | Planning & repo setup | PLAN.md, AGENTS.md | 40 | - |
| 1 | Environment setup with dependencies and CI checks | requirements.txt, pyproject.toml, GitHub Action | 80 | 0 |
| 2 | Android CustomCameraControl for frame & IMU streaming | android/custom_controls/camera_control.dart | 200 | 1 |
| 3 | PoseEstimator using MoveNet Lightning TFLite | ml/pose_estimator.py | 160 | 2 |
| 4 | RiskScorer computing RULA & REBA | ml/rula_reba.py | 140 | 3 |
| 5 | MODAPTS coder with unit tests | time_motion/modapts.py, tests/test_modapts.py | 180 | 3 |
| 6 | Overlay and UI integration | android/ui_live.py, android/main.py | 220 | 2,3,4,5 |
| 7 | Reporting PDF/Excel export | android/reporting.py | 120 | 6 |
| 8 | FastAPI backend and Dockerfile | backend/app.py, backend/Dockerfile, tests/test_backend.py | 100 | 1 |
| 9 | Permissions and build scripts | pyproject.toml, scripts/build_apk.sh, .github/workflows/android.yml | 90 | 1,6,7,8 |
|10 | Smoke test script for emulator | scripts/smoke_test.sh | 60 | 9 |

LOC totals are rough estimates and may change during implementation.
