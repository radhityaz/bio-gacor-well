# ErgoMotion Lab Plan

## Task Breakdown

1. **Environment Setup**
   - Files: `requirements.txt`, `pyproject.toml`
   - Install and pin Python, Flutter, and build dependencies.
   - LOC: ~40
   - Dependencies: none

2. **CustomCameraControl**
   - File: `android/custom_controls/camera_control.dart`
   - Flutter MethodChannel to stream camera frames and IMU sensors.
   - LOC: ~120
   - Depends on: Task 1

3. **PoseEstimator**
   - File: `ml/pose_estimator.py`
   - Wrap MoveNet Lightning (TFLite INT8) to return numpy array of 17 keypoints.
   - LOC: ~150
   - Depends on: Task 1

4. **RiskScorer**
   - File: `ml/rula_reba.py`
   - Compute RULA & REBA scores and risk level from keypoints.
   - LOC: ~120
   - Depends on: Task 3

5. **MODAPTS Coder**
   - File: `time_motion/modapts.py`
   - Heuristic mapping of motion segments to MODAPTS codes.
   - Test file: `tests/test_modapts.py`
   - LOC: ~140
   - Depends on: Task 3

6. **Overlay & UI**
   - Files: `android/ui_live.py`, modify `android/main.py`
   - Draw skeleton overlay, risk meter, and control buttons.
   - LOC: ~180
   - Depends on: Tasks 2,3,4,5

7. **Reporting**
   - File: `android/reporting.py`
   - Export PDF via reportlab and Excel via openpyxl.
   - LOC: ~100
   - Depends on: Task 6

8. **Backend**
   - File: `backend/app.py`, `backend/Dockerfile`
   - FastAPI `/deep` endpoint for heavy analysis.
   - LOC: ~80
   - Depends on: Task 3

9. **Permissions & Build**
   - Update `pyproject.toml` with camera & sensors permissions.
   - Scripts: `scripts/build_apk.sh`, GitHub Actions workflow.
   - LOC: ~60
   - Depends on: Tasks 1-8

10. **Smoke Test**
   - File: `scripts/smoke_test.sh`
   - Launch app via adb and verify core widgets.
   - LOC: ~50
   - Depends on: Task 9

## Estimated Total LOC
Approx. 1,040 lines across all tasks.

