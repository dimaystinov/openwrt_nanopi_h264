# openwrt_nanopi_h264

Этот репозиторий содержит пример сценария сборки пакетов для FriendlyWrt 24.10.x под NanoPi R3S (SoC Rockchip 3566).

Поддерживаются следующие пакеты:

- `rockchip-mpp`
- `gstreamer-rockchip` (включая `mpph264enc`)
- `gstreamer1-plugins-good`
- `gstreamer1-libav`

Скрипт `build_packages.sh` автоматизирует загрузку исходников FriendlyWrt,
подключение необходимого фида с Rockchip MPP и сборку указанных пакетов.

## Быстрый старт

```bash
./build_packages.sh
```

После завершения работы скрипта собранные `.ipk` файлы будут находиться в
`friendlywrt/bin/packages/`.

