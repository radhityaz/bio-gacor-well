import asyncio
import base64
import io

import flet as ft
import numpy as np
from PIL import Image

from controls import CustomCamera
from ml.pose_estimator import PoseEstimator
from ml.scorer import rula_score, reba_score


class LivePage(ft.UserControl):
    def __init__(self):
        super().__init__()
        self.estimator = PoseEstimator()
        self.image = ft.Image()
        self.camera = CustomCamera(on_frame=self.on_frame)
        self.text = ft.Text()

    def build(self):
        return ft.Column([
            ft.Stack([self.camera, self.image]),
            self.text,
        ])

    async def on_frame(self, data):
        frame = Image.open(io.BytesIO(base64.b64decode(data)))
        np_frame = np.array(frame)
        keypoints = self.estimator.estimate(np_frame)
        rula = rula_score(keypoints)
        reba = reba_score(keypoints)
        self.text.value = f"RULA: {rula} REBA: {reba}"
        self.image.src_base64 = data
        await self.image.update_async()
        await self.text.update_async()


def main(page: ft.Page):
    page.title = "ErgoMotion Lab"
    live = LivePage()
    page.tabs = ft.Tabs(
        tabs=[
            ft.Tab(text="Home", content=ft.Text("Welcome")),
            ft.Tab(text="Live View", content=live),
            ft.Tab(text="Review", content=ft.Text("Review")),
            ft.Tab(text="History", content=ft.Text("History")),
            ft.Tab(text="Settings", content=ft.Text("Settings")),
        ],
        expand=True,
    )


ft.app(target=main)
