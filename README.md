# Klinge Computer

Klinge is an FPGA computer designed by Lone Dynamics Corporation.

![Klinge](https://github.com/machdyne/klinge/blob/a071a7454161100a51e95bc0b22c07b44112e636/klinge.png)

This repo contains schematics, pinouts, a 3D-printable case, example gateware and documentation.

Find more information on the [Klinge product page](https://machdyne.com/product/klinge-computer/).

## Programming Klinge

Klinge has a JTAG interface and ships with a [DFU bootloader](https://github.com/machdyne/tinydfu-bootloader) that allows the included flash [MMOD](https://machdyne.com/product/mmod) to be programmed over the USB-C port.

### DFU

The DFU bootloader is available for 5 seconds after power-on, issuing a DFU command during this period will stop the boot process until the DFU device is detached. If no command is received the boot process will continue and the user gateware will be loaded.

Install [dfu-util](http://dfu-util.sourceforge.net) (Debian/Ubuntu):

```
$ sudo apt install dfu-util
```

Update the user gateware on the flash MMOD:

```
$ sudo dfu-util -a 0 -D image.bit
```

Detach the DFU device and continue the boot process:

```
$ sudo dfu-util -a 0 -e
```

It is possible to update the bootloader itself using DFU but you shouldn't attempt this unless you have a JTAG programmer (or another method to program the MMOD) available, in case you need to restore the bootloader.

### JTAG

These examples assume you're using a "USB Blaster" JTAG cable, see the header pinout below. You will need to have [openFPGALoader](https://github.com/trabucayre/openFPGALoader) installed.

Program the configuration SRAM:

```
openFPGALoader -c usb-blaster image.bit
```

Program the flash MMOD:

```
openFPGALoader -f -c usb-blaster images/bootloader/tinydfu_klinge.bit
```

## Blinky 

Building the blinky example requires [Yosys](https://github.com/YosysHQ/yosys), [nextpnr-ecp5](https://github.com/YosysHQ/nextpnr) and [Project Trellis](https://github.com/YosysHQ/prjtrellis).

Assuming they are installed, you can simply type `make` to build the gateware, which will be written to output/blinky.bin. You can then use [openFPGALoader](https://github.com/trabucayre/openFPGALoader) or dfu-util to write the gateware to the device.

## Linux

See the [Kakao Linux](https://github.com/machdyne/kakao) repo for the latest instructions.

### Prebuilt Images

Copy the files from the `images/linux` directory to the root directory of a FAT-formatted MicroSD card.

Klinge ships with LiteX gateware on the user gateware section of the MMOD that is compatible with these images. After several seconds the Linux penguin should appear on the screen (HDMI) followed by a login prompt.

### Building Linux

Please follow the setup instructions in the [linux-on-litex-vexriscv](https://github.com/litex-hub/linux-on-litex-vexriscv) repo and then:

1. Build the Linux-capable gateware:

```
$ cd linux-on-litex-vexriscv
$ ./make.py --board klinge --uart-baudrate 115200 --build

$ ls build/klinge
```

2. Write the gateware to the MMOD using USB DFU:

```
$ sudo dfu-util -a 0 -D build/klinge/gateware/klinge.bit
```

3. Copy the device tree binary `build/klinge/klinge.dtb` to a FAT-formatted MicroSD card.


4. Build the Linux kernel and root filesystem:

See the [Kakao Linux](https://github.com/machdyne/kakao?tab=readme-ov-file#optional-building-kakao-linux) repo for instructions.

5. Copy the Image and rootfs.cpio files generated in the previous step to the boot partition of the MicroSD card, in addition to the following files:

6. Copy the OpenSBI binary (included in this repo as `klinge/images/linux/opensbi.bin`) to the MicroSD card. Alternatively, you can build this binary by following [these instructions](https://github.com/litex-hub/linux-on-litex-vexriscv#-generating-the-opensbi-binary-optional).

7. Copy `klinge/images/linux/boot.json` to the MicroSD card.

8. Power-cycle Klinge. After Linux has finished booting you should see a login prompt on the HDMI display.

## LiteX

### Installing LiteX

If you haven't yet installed LiteX please see the [LiteX quick start guide](https://github.com/enjoy-digital/litex#quick-start-guide) for details on installing LiteX.

### Building Custom Gateware

Build the LiteX gateware:

```
$ cd litex-boards/litex_boards/targets
$ ./machdyne_klinge.py --cpu-type=vexriscv --cpu-variant=lite --sys-clk-freq 40000000 --uart-baudrate 1000000 --uart-name serial --build
```

Program the LiteX gateware to SRAM over JTAG:

```
$ ./machdyne_klinge.py --cable usb-blaster --load
```

Or program the LiteX gateware to flash over DFU:

```
$ sudo dfu-util -a 0 -D build/machdyne_klinge/gateware/machdyne_klinge.bit
```

## JTAG Header

The 3.3V JTAG header can be used to program the FPGA SRAM as well as the MMOD flash memory. It can also be used to provide power (5V) to the board.

```
2 4 6
1 3 5
```

| Pin | Signal |
| --- | ------ |
| 1 | TCK |
| 2 | TDI |
| 3 | TDO |
| 4 | TMS |
| 5 | 5V0 |
| 6 | GND |

## Board Revisions

| Revision | Notes |
| -------- | ----- |
| V1 | Current production version |

## License

The contents of this repo are released under the [Lone Dynamics Open License](LICENSE.md).

Note: You can use these designs for commercial purposes but we ask that instead of producing exact clones, that you either replace our trademarks and logos with your own or add your own next to ours.
