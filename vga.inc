set_mode_x:
outb 0x3C0, 0x10
outb 0x3C0, 0x41

outb 0x3C0, 0x11
outb 0x3C0, 0

outb 0x3C0, 0x12
outb 0x3C0, 0xF

outb 0x3C0, 0x13
outb 0x3C0, 0x0
outb 0x3C0, 0x14
outb 0x3C0, 0x0

outb 0x3C2, 0xE3

outb 0x3C4, 0x01
outb 0x3C5, 0x01

outb 0x3C4, 0x03
outb 0x3C5, 0

outb 0x3C4, 0x04
outb 0x3C5, 0

outb 0x3CE, 0x05
outb 0x3CF, 0x40

outb 0x3CE, 0x06
outb 0x3CF, 0x05

outb 0x3D4, 0x00
outb 0x3D5, 0x5F

outb 0x3D4, 0x01
outb 0x3D5, 0x4F

outb 0x3D4, 0x02
outb 0x3D5, 0x50

outb 0x3D4, 0x03
outb 0x3D5, 0x82

outb 0x3D4, 0x04
outb 0x3D5, 0x54

outb 0x3D4, 0x05
outb 0x3D5, 0x80

outb 0x3D4, 0x06
outb 0x3D5, 0x0D

outb 0x3D4, 0x07
outb 0x3D5, 0x3E

outb 0x3D4, 0x08
outb 0x3D5, 0

outb 0x3D4, 0x09
outb 0x3D5, 0x41

outb 0x3D4, 0x10
outb 0x3D5, 0xEA

outb 0x3D4, 0x11
outb 0x3D5, 0xAC

outb 0x3D4, 0x12
outb 0x3D5, 0xDF

outb 0x3D4, 0x13
outb 0x3D5, 0x28

outb 0x3D4, 0x14
outb 0x3D5, 0

outb 0x3D4, 0x15
outb 0x3D5, 0xE7

outb 0x3D4, 0x16
outb 0x3D5, 0x06

outb 0x3D4, 0x17
outb 0x3D5, 0xE3
ret