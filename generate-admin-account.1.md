%generate-admin-account.bash(1) user manual
%R. S. Doiel
%2022-10-10

# NAME

generate-admin-account.bash

# SYNOPSIS

generate-admin-account.bash USERNAME [GITHUB_USERNAME]

# DESCRIPTION

generate-admin-account.bash sets up an admin user account per DLD group practice for
Ubuntu GNU/Linux machines. In addition to adding the user it adds
the groups we use to admin a machine, creates a README.1st file in
the home directory with instructions to change the password
and pulls ssh public keys from GitHub for the user we're creating.

The script should be run using sudo.

# EXAMPLE

	sudo generate-admin-account.bash jane.doe

This would create an admin account for jane.doe.

	sudo generate-admin-account.bash jane.doe jdeo

This could create an account for jane.doe with the GitHub username
of jdoe.

