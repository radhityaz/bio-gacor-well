from flet import Page, app
from ui_live import live_view


def main(page: Page) -> None:
    live_view(page)


app(target=main)
