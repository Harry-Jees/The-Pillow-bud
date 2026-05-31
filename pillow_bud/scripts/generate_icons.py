from PIL import Image
import os

src = r"C:\Users\Otta Komban\Downloads\imglogo.jfif"
img = Image.open(src).convert("RGBA")

base = r"D:\Kiro\Pillow bud\pillow_bud"

# ---- WINDOWS: .ico ----
ico_sizes = [16, 32, 48, 64, 128, 256]
ico_images = [img.resize((s, s), Image.LANCZOS) for s in ico_sizes]
ico_path = os.path.join(base, r"windows\runner\resources\app_icon.ico")
ico_images[0].save(ico_path, format="ICO", sizes=[(s, s) for s in ico_sizes], append_images=ico_images[1:])
print(f"  windows/runner/resources/app_icon.ico")

# ---- LINUX: PNGs ----
linux_dir = os.path.join(base, r"linux\runner\resources")
os.makedirs(linux_dir, exist_ok=True)
for size in [64, 128]:
    name = f"app_icon_{size}.png"
    img.resize((size, size), Image.LANCZOS).save(os.path.join(linux_dir, name))
img.resize((128, 128), Image.LANCZOS).save(os.path.join(linux_dir, "app_icon.png"))
print(f"  linux/runner/resources/ (3 PNGs)")

# ---- MACOS: .icns-compatible PNGs ----
macos_dir = os.path.join(base, r"macos\runner\Assets.xcassets\AppIcon.appiconset")
os.makedirs(macos_dir, exist_ok=True)
macos_sizes = {
    "app_icon_16.png": 16,
    "app_icon_32.png": 32,
    "app_icon_64.png": 64,
    "app_icon_128.png": 128,
    "app_icon_256.png": 256,
    "app_icon_512.png": 512,
    "app_icon_1024.png": 1024,
}
for name, size in macos_sizes.items():
    img.resize((size, size), Image.LANCZOS).save(os.path.join(macos_dir, name))
print(f"  macos/runner/Assets.xcassets/AppIcon.appiconset/ ({len(macos_sizes)} PNGs)")

# ---- WEB: favicon + PWA ----
web_icons_dir = os.path.join(base, r"web\icons")
os.makedirs(web_icons_dir, exist_ok=True)

favicon_sizes = [16, 32, 48]
favicon_images = [img.resize((s, s), Image.LANCZOS) for s in favicon_sizes]
favicon_path = os.path.join(base, r"web\favicon.ico")
favicon_images[0].save(favicon_path, format="ICO", sizes=[(s, s) for s in favicon_sizes], append_images=favicon_images[1:])
print(f"  web/favicon.ico")

web_sizes = {
    "Icon-192.png": 192,
    "Icon-512.png": 512,
    "Icon-maskable-192.png": 192,
    "Icon-maskable-512.png": 512,
}
for name, size in web_sizes.items():
    resized = img.resize((size, size), Image.LANCZOS)
    if "maskable" in name:
        margin = int(size * 0.1)
        canvas = Image.new("RGBA", (size, size), (255, 255, 255, 0))
        inner = resized.resize((size - 2 * margin, size - 2 * margin), Image.LANCZOS)
        canvas.paste(inner, (margin, margin), inner)
        canvas.save(os.path.join(web_icons_dir, name))
    else:
        resized.save(os.path.join(web_icons_dir, name))
print(f"  web/icons/ (4 PNGs)")

img.resize((64, 64), Image.LANCZOS).save(os.path.join(base, r"web\favicon.png"))
print(f"  web/favicon.png")

print("\nAll 6 platform icons regenerated!")
