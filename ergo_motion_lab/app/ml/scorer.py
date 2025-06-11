import numpy as np


def rula_score(keypoints: np.ndarray) -> int:
    """Compute a dummy RULA score."""
    return int(np.clip(np.mean(keypoints), 1, 7))


def reba_score(keypoints: np.ndarray) -> int:
    """Compute a dummy REBA score."""
    return int(np.clip(np.std(keypoints), 1, 12))
