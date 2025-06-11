import cv2
import numpy as np
import tflite_runtime.interpreter as tflite


class PoseEstimator:
    def __init__(self, model_path="model.tflite"):
        self.interpreter = tflite.Interpreter(model_path=model_path)
        self.interpreter.allocate_tensors()
        input_details = self.interpreter.get_input_details()[0]
        output_details = self.interpreter.get_output_details()[0]
        self.input_index = input_details["index"]
        self.output_index = output_details["index"]
        _, self.height, self.width, _ = input_details["shape"]

    def estimate(self, frame: np.ndarray) -> np.ndarray:
        img = cv2.resize(frame, (self.width, self.height))
        img = img.astype("float32")
        img = np.expand_dims(img, axis=0)
        self.interpreter.set_tensor(self.input_index, img)
        self.interpreter.invoke()
        keypoints = self.interpreter.get_tensor(self.output_index)[0]
        return keypoints
