import flet as ft

class CustomCamera(ft.UserControl):
    def __init__(self, on_frame=None):
        super().__init__()
        self.on_frame = on_frame
        self._channel = ft.platform.PlatformMethodChannel('camera_stream')

    async def did_mount_async(self):
        self._channel.set_method_call_handler(self._handle_method)

    async def _handle_method(self, method, args):
        if method == 'newFrame' and self.on_frame:
            await self.on_frame(args)

    def build(self):
        return ft.PlatformView(view_type='camera_view')
