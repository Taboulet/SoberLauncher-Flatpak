# SoberLauncher.pro — qmake-driven build for a Python/PyInstaller app (offline-friendly)

TEMPLATE = aux
CONFIG += no_qt
TARGET = SoberLauncher

# Paths (use qmake-style $$var, not make-style)
app_prefix = /app
wheels_dir = flatpak/wheels
desktop_file = flatpak/org.taboulet.SoberLauncher.desktop
icon_file = flatpak/SoberLauncher.svg
binary_out = dist/SoberLauncher

# Build: install from vendored wheels and run pyinstaller
build.commands = \
    python3 -m pip install --no-index --find-links=$$wheels_dir --prefix=$$app_prefix pyqtdarktheme altgraph && \
    python3 -m pip install --no-index --find-links=$$wheels_dir --prefix=$$app_prefix PyQt6 PyQt6-sip PyQt6-Qt6 && \
    python3 -m pip install --no-index --find-links=$$wheels_dir --prefix=$$app_prefix pyinstaller && \
    PATH="$$app_prefix/bin:$$PATH" pyinstaller --noconfirm SoberLauncher.spec

# Install: copy binary and assets
install.commands = \
    install -Dm755 $$binary_out $$app_prefix/bin/SoberLauncher && \
    install -Dm644 $$desktop_file $$app_prefix/share/applications/org.taboulet.SoberLauncher.desktop && \
    install -Dm644 $$icon_file $$app_prefix/share/icons/hicolor/scalable/apps/org.taboulet.SoberLauncher.svg

# Optional clean
clean.commands = \
    rm -rf build dist __pycache__

QMAKE_EXTRA_TARGETS += build install clean
all.depends = build
QMAKE_EXTRA_TARGETS += all
QMAKE_DEFAULT_TARGET = all
