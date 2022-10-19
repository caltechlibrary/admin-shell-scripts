
Admin Shell Scripts
===================

The repository has a collection of administrative shell
scripts for managing Ubuntu Servers and their systems.

Documentation
-------------

Each script includes supports for "-h" and "--help".
The output of the help option is suitable to process
with Pandoc into a manual page.

```
    mkdir -p man/man1
    check-for-reboot.bash -h |\
    pandoc --from markdown --to man -s \
    >man/man1/check-for-reboot.1
```


