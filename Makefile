all:
    python3 -m pip install --no-deps --prefix=/app pyqtdarktheme altgraph
    python3 -m pip install --no-deps --prefix=/app PyQt6==6.8.0 PyQt6-sip==13.10.2 PyQt6-Qt6==6.8.1
    python3 -m pip install --no-deps --prefix=/app pyinstaller
    PATH="/app/bin:$$PATH" pyinstaller --noconfirm SoberLauncher.spec

install:
    install -Dm755 dist/SoberLauncher /app/bin/SoberLauncher
    install -Dm644 flatpak/org.taboulet.SoberLauncher.desktop /app/share/applications/org.taboulet.SoberLauncher.desktop
    install -Dm644 flatpak/SoberLauncher.svg /app/share/icons/hicolor/scalable/apps/org.taboulet.SoberLauncher.svg
