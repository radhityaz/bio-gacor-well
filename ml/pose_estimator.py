from __future__ import annotations

from pathlib import Path

import numpy as np
import tensorflow as tf


class PoseEstimator:
    """Wrapper for MoveNet Lightning TFLite model."""

    def __init__(self, model_path: str | Path) -> None:
        self.interpreter = tf.lite.Interpreter(model_path=str(model_path))
        self.interpreter.allocate_tensors()
        input_details = self.interpreter.get_input_details()[0]
        self.input_index = input_details["index"]
        self.input_shape = input_details["shape"]
        self.output_index = self.interpreter.get_output_details()[0]["index"]

    def estimate(self, image: np.ndarray) -> np.ndarray:
        """Run pose estimation on an RGB image array."""
        img = tf.image.resize_with_pad(image, self.input_shape[1], self.input_shape[2])
        img = tf.expand_dims(img, axis=0)
        img = tf.cast(img, tf.uint8)
        self.interpreter.set_tensor(self.input_index, img.numpy())
        self.interpreter.invoke()
        keypoints = self.interpreter.get_tensor(self.output_index)[0]
        return keypoints[:, :2]
