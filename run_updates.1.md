
# NAME

run_updates.bash

# SYNOPSIS

run_updates.bash HOST_NAME

# DESCRIPTION

This script runs the following "apt" actions

- update
- dist-upgrade
- autoremove
- autoclean

It then runs "sudo snap refresh" before calling
"check-for-reboot.bash" on a remote system..

# EXAMPLE

~~~
  run_updates.bash apps.library.caltech.edu
~~~

