# Mono-Scripts

Custom scripts for configuring servers. The primary goals are to keep scripts simple and idempotent.

Requires bash, and must be ran from the directory the script is in

Configuration and secrets for the scripts will be handled mainly through environment variables.

These scripts make assumptions that the installers for software are not malicious,
eg: piping curl into bash for an official server hosting over https.

# Distros

Currently just supporting debian

# Use Cases

- Configuring new servers (linode, GCE, bare-metal)
- Running as part of a Dockerfile
- Running as part of a Vagrant configuration