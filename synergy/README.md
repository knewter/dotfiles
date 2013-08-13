# Synergy

To get my chromebook / main desktop synergy setup working, two things have to happen:

1) On the main desktop, `synergys -c ~/.synergy.conf`
2) On the chromebook, do the following:
```
# In a chromeos terminal:
shell
sudo enter-chroot
synergyc -n chromebook 192.168.1.136
```
