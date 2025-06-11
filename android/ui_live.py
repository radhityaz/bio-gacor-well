from __future__ import annotations

from flet import Column, ElevatedButton, Page, Row, Text


def live_view(page: Page) -> None:
    page.title = "ErgoMotion Live"
    page.add(
        Column(
            [
                Text("Live View"),
                Row([
                    ElevatedButton("Start"),
                    ElevatedButton("Stop"),
                ]),
            ]
        )
    )
