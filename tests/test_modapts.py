import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parents[1]))

from time_motion.modapts import code_motion


def test_code_motion_basic():
    motions = ["reach", "grasp", "move", "release"]
    assert code_motion(motions) == ["R1", "G1", "M1", "RL1"]


def test_code_motion_unknown():
    assert code_motion(["foo"]) == ["?"]
