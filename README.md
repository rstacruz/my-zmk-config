```
warning: HAS_NORDIC_DRIVERS (defined at modules/hal_nordic/Kconfig:7) has direct dependencies 0 with value n, but is currently being y-selected by the following symbols:
 - SOC_SERIES_NRF52X (defined at soc/arm/nordic_nrf/nrf52/Kconfig.series:6), with value y, direct dependencies <choice> (value: y), and select condition <choice> (value: y)

warning: HAS_NRFX (defined at modules/hal_nordic/nrfx/Kconfig:4) has direct dependencies 0 with value n, but is currently being y-selected by the following symbols:
 - SOC_SERIES_NRF52X (defined at soc/arm/nordic_nrf/nrf52/Kconfig.series:6), with value y, direct dependencies <choice> (value: y), and select condition <choice> (value: y)

warning: NRFX_CLOCK (defined at modules/hal_nordic/nrfx/Kconfig:14) has direct dependencies HAS_HW_NRF_CLOCK && HAS_NRFX && 0 with value n, but is currently being y-selected by the following symbols:
 - CLOCK_CONTROL_NRF (defined at drivers/clock_control/Kconfig.nrf:13), with value y, direct dependencies SOC_COMPATIBLE_NRF && CLOCK_CONTROL (value: y), and select condition !CLOCK_CONTROL_NRF_FORCE_ALT && SOC_COMPATIBLE_NRF && CLOCK_CONTROL (value: y)

warning: NRFX_CLOCK_LFXO_TWO_STAGE_ENABLED (defined at modules/hal_nordic/nrfx/Kconfig:18) has direct dependencies NRFX_CLOCK && HAS_NRFX && 0 with value n, but is currently being y-selected by the following symbols:
 - CLOCK_CONTROL_NRF_K32SRC_XTAL (defined at drivers/clock_control/Kconfig.nrf:36), with value y, direct dependencies <choice CLOCK_CONTROL_NRF_SOURCE> (value: y), and select condition !SOC_SERIES_BSIM_NRFXX && !CLOCK_CONTROL_NRF_FORCE_ALT && <choice CLOCK_CONTROL_NRF_SOURCE> (value: y)

warning: NRFX_GPIOTE (defined at modules/hal_nordic/nrfx/Kconfig:65) has direct dependencies HAS_HW_NRF_GPIOTE && HAS_NRFX && 0 with value n, but is currently being y-selected by the following symbols:
 - GPIO_NRFX (defined at drivers/gpio/Kconfig.nrfx:4), with value y, direct dependencies SOC_FAMILY_NRF && GPIO (value: y), and select condition SOC_FAMILY_NRF && GPIO (value: y)

warning: NRFX_NVMC (defined at modules/hal_nordic/nrfx/Kconfig:95) has direct dependencies HAS_NRFX && 0 with value n, but is currently being y-selected by the following symbols:
 - SOC_FLASH_NRF (defined at drivers/flash/Kconfig.nrf:10), with value y, direct dependencies SOC_FAMILY_NRF && !FLASH_NRF_FORCE_ALT && FLASH (value: y), and select condition SOC_FAMILY_NRF && !FLASH_NRF_FORCE_ALT && FLASH (value: y)

warning: NRFX_POWER (defined at modules/hal_nordic/nrfx/Kconfig:102) has direct dependencies HAS_HW_NRF_POWER && HAS_NRFX && 0 with value n, but is currently being y-selected by the following symbols:
 - USB_NRFX (defined at /keeb/config/boards/arm/technikable/Kconfig.defconfig:14, drivers/usb/device/Kconfig:78), with value y, direct dependencies (USB && BOARD_TECHNIKABLE) || (HAS_HW_NRF_USBD && USB_DEVICE_DRIVER) (value: y), and select condition HAS_HW_NRF_USBD && USB_DEVICE_DRIVER (value: y)

warning: NRFX_USBD (defined at modules/hal_nordic/nrfx/Kconfig:384) has direct dependencies HAS_HW_NRF_USBD && HAS_NRFX && 0 with value n, but is currently being y-selected by the following symbols:
 - USB_NRFX (defined at /keeb/config/boards/arm/technikable/Kconfig.defconfig:14, drivers/usb/device/Kconfig:78), with value y, direct dependencies (USB && BOARD_TECHNIKABLE) || (HAS_HW_NRF_USBD && USB_DEVICE_DRIVER) (value: y), and select condition HAS_HW_NRF_USBD && USB_DEVICE_DRIVER (value: y)

error: Aborting due to Kconfig warnings

CMake Error at /keeb/zephyr/cmake/kconfig.cmake:272 (message):
  command failed with return code: 1
Call Stack (most recent call first):
  /keeb/zephyr/cmake/app/boilerplate.cmake:543 (include)
  /keeb/zephyr/share/zephyr-package/cmake/ZephyrConfig.cmake:24 (include)
  /keeb/zephyr/share/zephyr-package/cmake/ZephyrConfig.cmake:35 (include_boilerplate)
  CMakeLists.txt:15 (find_package)


-- Configuring incomplete, errors occurred!
FATAL ERROR: command exited with status 1: /usr/local/bin/cmake -DWEST_PYTHON=/usr/bin/python3 -B/keeb/build -S/keeb/zmk/app -GNinja -DBOARD=technikable -DZMK_CONFIG=/keeb/config
```
