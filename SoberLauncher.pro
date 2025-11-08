# SoberLauncher.pro — qmake-driven build for a Python/PyInstaller app
TEMPLATE = aux
CONFIG += no_qt
TARGET = SoberLauncher

# Paths (use qmake $$ expansion)
app_prefix = /app
desktop_file = flatpak/org.taboulet.SoberLauncher.desktop
icon_file = flatpak/SoberLauncher.svg
binary_out = dist/SoberLauncher

# Build: upgrade pip, install packages into $$app_prefix, run PyInstaller via python -m
build.commands = \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-deps --prefix=$$app_prefix pyqtdarktheme altgraph && \
    python3 -m pip install --no-deps --prefix=$$app_prefix PyQt6==6.8.0 PyQt6_sip==13.10.2 PyQt6_Qt6==6.8.1 && \
    python3 -m pip install --no-deps --prefix=$$app_prefix pyinstaller && \
    cp -v flatpak/io.github.taboulet.SoberLauncher-Flatpak.desktop ./io.github.taboulet.SoberLauncher-Flatpak.desktop || cp -v flatpak/org.taboulet.SoberLauncher.desktop ./org.taboulet.SoberLauncher.desktop || true && \
    cp -v flatpak/SoberLauncher.svg ./SoberLauncher.svg || true && \
    python3 -m PyInstaller --noconfirm SoberLauncher.spec

# Install: place binary and desktop/icon into /app
install.commands = \
    install -Dm755 $$binary_out $$app_prefix/bin/SoberLauncher && \
    install -Dm644 $$desktop_file $$app_prefix/share/applications/org.taboulet.SoberLauncher.desktop && \
    install -Dm644 $$icon_file $$app_prefix/share/icons/hicolor/scalable/apps/org.taboulet.SoberLauncher.svg

# Clean target
clean.commands = \
    rm -rf build dist __pycache__

# Wire up qmake targets
QMAKE_EXTRA_TARGETS += build install clean
all.depends = build
QMAKE_EXTRA_TARGETS += all
QMAKE_DEFAULT_TARGET = all
