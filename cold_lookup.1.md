%cold_lookup.bash user manual
% R. S. Doiel
% 2025-07-29

# NAME

cold_lookup.bash

# SYNOPSIS

cold_lookup.bash C_NAME KEY

# DESCRIPTION

cold_lookup.bash will look up the KEY record in the C_NAME (dataset collection)
using the COLD API. This provides you with a quick way to see the record that
will show up for a person in the COLD web application.

It performs a curl call.
# OPTION

-h, --help, help
| display this help message

# EXAMPLE

~~~
./cold_lookup.bash people.ds Minchew-B-M
~~~

