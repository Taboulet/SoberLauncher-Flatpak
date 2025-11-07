# -*- mode: python ; coding: utf-8 -*-

block_cipher = None

a = Analysis(
    ['SoberLauncher.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('SoberLauncher.svg', '.'),
        ('org.taboulet.SoberLauncher.desktop', '.'),
    ],
    hiddenimports=[
        'pkgutil',
        'PyQt6',
        'PyQt6.QtWidgets',
        'PyQt6.QtGui',
        'PyQt6.QtCore',
        'PyQt6.QtSvg',
        'qdarktheme',
        'PyQt6.sip',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='SoberLauncher',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
