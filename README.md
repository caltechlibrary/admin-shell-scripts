
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

Check the man page or [user manual](user-manual.html) for
documentation on individual scripts.


Requirements
------------

Aside from the standard Unix/POSIX system utilities
the following commands are needed by one or more shell scripts.

- bash
- make
- pandoc
- makepasswd
- mysql


Installation
------------

1. Clone this repository
2. Make sure Pandoc is installed
3. Run make and make install

By default it will install scripts in `$HOME/bin` and manpages
in `$HOME/man`.  If you need to install in `/usr/local` run make
with the prefix option.

Install in your home directory

```
    git clone https://github.com/caltechlibrary/admin-shell-scripts
    cd admin-shell-scripts
    make
    make install
```

Install in `/usr/local`

```
    git clone https://github.com/caltechlibrary/admin-shell-scripts
    cd admin-shell-scripts
    make
    make install prefix=/usr/local
```

Uninstall from your home diriectory


```
    cd admin-shell-scripts
    make uninstall
```

Uninstall form `/usr/local`

```
    cd admin-shell-scripts
    make uninstall prefix=/usr/local
```

