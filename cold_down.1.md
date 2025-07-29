%cold_down.bash user manual
% R. S. Doiel
% 2025-07-29

# NAME

cold_down.bash

# SYNOPSIS

cold_down.bash

# DESCRIPTION

cold_down.bash brings cold down in an orderly fashion. It follows
the following steps

1. Stops the front end service (cold)
2. Stops the reports system (cold_reports)
3. Stops the api service (cold_api)

# OPTION

-h, --help, help
| display this help message

# EXAMPLE

~~~
./cold_down.bash
~~~

