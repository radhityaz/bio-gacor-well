from __future__ import annotations

import numpy as np


class RiskScorer:
    """Compute RULA and REBA scores from body keypoints."""

    def __init__(self) -> None:
        pass

    def rula(self, keypoints: np.ndarray) -> int:
        """Dummy RULA computation."""
        # Placeholder heuristic: sum of y coordinates
        score = int(np.clip(np.mean(keypoints[:, 1]) * 10, 1, 7))
        return score

    def reba(self, keypoints: np.ndarray) -> int:
        """Dummy REBA computation."""
        score = int(np.clip(np.mean(keypoints[:, 0]) * 10, 1, 15))
        return score
