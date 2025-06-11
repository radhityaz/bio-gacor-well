import asyncio
import base64
import io
import time

import flet as ft
import numpy as np
from PIL import Image, ImageDraw

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
        self._last_update = time.time()

    def build(self):
        return ft.Column([
            ft.Stack([self.camera, self.image]),
            self.text,
        ])

    async def on_frame(self, data):
        frame = Image.open(io.BytesIO(base64.b64decode(data))).convert("RGB")
        np_frame = np.array(frame)
        keypoints = self.estimator.estimate(np_frame)
        rula = rula_score(keypoints)
        reba = reba_score(keypoints)
        self.text.value = f"RULA: {rula} REBA: {reba}"

        xy = np.stack(
            (
                keypoints[:, 1] * frame.width,
                keypoints[:, 0] * frame.height,
            ),
            axis=1,
        )
        draw = ImageDraw.Draw(frame)
        pairs = [
            (0, 1),
            (0, 2),
            (1, 3),
            (2, 4),
            (5, 6),
            (5, 7),
            (7, 9),
            (6, 8),
            (8, 10),
            (11, 12),
            (5, 11),
            (6, 12),
            (11, 13),
            (13, 15),
            (12, 14),
            (14, 16),
        ]
        for a, b in pairs:
            draw.line(
                [tuple(xy[a]), tuple(xy[b])],
                fill=(0, 255, 0),
                width=2,
            )
        buffer = io.BytesIO()
        frame.save(buffer, format="JPEG")
        self.image.src_base64 = base64.b64encode(buffer.getvalue()).decode()
        await self.image.update_async()
        await self.text.update_async()
        elapsed = time.time() - self._last_update
        wait = max(0.0, 1 / 30 - elapsed)
        self._last_update = time.time()
        if wait:
            await asyncio.sleep(wait)


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
