TEMPLATE = aux
CONFIG += no_qt
TARGET = SoberLauncher

app_prefix = /app
desktop_repo1 = flatpak/io.github.taboulet.SoberLauncher-Flatpak.desktop
desktop_repo2 = flatpak/org.taboulet.SoberLauncher.desktop
icon_repo_glob = flatpak/*.svg
binary_out = dist/SoberLauncher

build.commands = \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install --no-deps --prefix=$$app_prefix pyqtdarktheme altgraph && \
    python3 -m pip install --no-deps --prefix=$$app_prefix PyQt6==6.8.0 PyQt6_sip==13.10.2 PyQt6_Qt6==6.8.1 && \
    python3 -m pip install --no-deps --prefix=$$app_prefix pyinstaller && \
    ( [ -f $$desktop_repo1 ] && cp -v $$desktop_repo1 ./io.github.taboulet.SoberLauncher-Flatpak.desktop ) || true && \
    ( [ -f $$desktop_repo2 ] && cp -v $$desktop_repo2 ./org.taboulet.SoberLauncher.desktop ) || true && \
    ( [ -f io.github.taboulet.SoberLauncher-Flatpak.desktop ] && [ ! -f org.taboulet.SoberLauncher.desktop ] && cp -v io.github.taboulet.SoberLauncher-Flatpak.desktop org.taboulet.SoberLauncher.desktop || true ) && \
    ( [ -f org.taboulet.SoberLauncher.desktop ] && [ ! -f io.github.taboulet.SoberLauncher-Flatpak.desktop ] && cp -v org.taboulet.SoberLauncher.desktop io.github.taboulet.SoberLauncher-Flatpak.desktop || true ) && \
    ( for f in $$icon_repo_glob; do [ -f "$$f" ] && cp -v "$$f" ./io.github.taboulet.SoberLauncher-Flatpak.svg && break; done ) || true && \
    python3 -m PyInstaller --noconfirm SoberLauncher.spec

install.commands = \
    install -Dm755 $$binary_out $$app_prefix/bin/SoberLauncher && \
    ( [ -f flatpak/io.github.taboulet.SoberLauncher-Flatpak.desktop ] && install -Dm644 flatpak/io.github.taboulet.SoberLauncher-Flatpak.desktop $$app_prefix/share/applications/io.github.taboulet.SoberLauncher-Flatpak.desktop ) || \
    ( [ -f flatpak/org.taboulet.SoberLauncher.desktop ] && install -Dm644 flatpak/org.taboulet.SoberLauncher.desktop $$app_prefix/share/applications/org.taboulet.SoberLauncher.desktop ) || true && \
    ( [ -f flatpak/SoberLauncher.svg ] && install -Dm644 flatpak/SoberLauncher.svg $$app_prefix/share/icons/hicolor/scalable/apps/io.github.taboulet.SoberLauncher-Flatpak.svg ) || \
    ( [ -f io.github.taboulet.SoberLauncher-Flatpak.svg ] && install -Dm644 io.github.taboulet.SoberLauncher-Flatpak.svg $$app_prefix/share/icons/hicolor/scalable/apps/io.github.taboulet.SoberLauncher-Flatpak.svg ) || true

# Clean target
clean.commands = \
    rm -rf build dist __pycache__ *.spec.spec

QMAKE_EXTRA_TARGETS += build install clean
all.depends = build
QMAKE_EXTRA_TARGETS += all
QMAKE_DEFAULT_TARGET = all
