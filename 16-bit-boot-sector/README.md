<div align="center">

![preview](./screen.png)

</div>

# How to use with QEMU

```
$> nasm -f bin boot-sector.asm -o boot-sector.bin
$> qemu-system-x86_64  boot-sector.bin
```