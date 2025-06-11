from __future__ import annotations

from pathlib import Path

from openpyxl import Workbook
from reportlab.pdfgen import canvas


def export_pdf(path: str | Path, data: str) -> None:
    c = canvas.Canvas(str(path))
    c.drawString(100, 750, data)
    c.save()


def export_excel(path: str | Path, rows: list[list[str]]) -> None:
    wb = Workbook()
    ws = wb.active
    for row in rows:
        ws.append(row)
    wb.save(str(path))
