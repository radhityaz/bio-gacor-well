from __future__ import annotations

from typing import List


def code_motion(motions: List[str]) -> List[str]:
    """Map simple motion descriptors to MODAPTS codes."""
    mapping = {
        "reach": "R1",
        "grasp": "G1",
        "move": "M1",
        "release": "RL1",
    }
    return [mapping.get(m, "?") for m in motions]
