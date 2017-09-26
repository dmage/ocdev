# ocdev

```
$ ocdev
usage: ocdev <command>

Available commands:
  show-toplevel       Show the absolute path of the top-level directory
  show-bindir         Show the absolute path of the directory with OpenShift binaries
  env                 Show adjusted environment variables
  oc                  Run oc from the current source tree
  ocdefault           Run oc command as the system:admin user in the default namespace
  oadm                Run openshift admin as the system:admin user
  exec                Run a program from the directory with OpenShift binaries
  build               Build an OpenShift binary
  docker-build        Cross-compile an OpenShift binary for a Docker image
  login-as-developer  Login as the developer user
  login-as-pruner     Login as the pruner user

Commands for components:
  cluster             Manage an OpenShift cluster
  openshift           Manage the OpenShift server
  pod                 Manage the pod image
  registry            Manage the integrated Docker registry
  prometheus          Manage Prometheus
  create-defaults     Create the user 'developer', the project 'myproject', and default imagestreams

Usage examples:
  ./hack/build-go.sh cmd/oc
  ocdev cluster build
  ocdev openshift start --loglevel=4
  ocdev registry up

  ocdev registry update
```

## Extending

### In bash

Create an executable file named `.ocdev-COMMAND` in your PATH directory. For example:

    $ mkdir ~/bin && export PATH="$PATH:$HOME/bin"
    $ cat >~/bin/.ocdev-hello <<EOF
    #!/bin/bash -efu

    usage() {
        echo "usage: $OCDEV_PROGNAME <command>"
        echo
        echo "Briefly describe your command here."
    }

    ocdevhello-world() {
        echo "Hello, world!"
    }

    ocdevutil-main ".ocdevhello-" "ocdevhello-" "$@"
    EOF
    $ chmod +x ~/bin/.ocdev-hello
    $ ocdev hello
    usage: ocdev hello <command>

    Briefly describe your command here.
    $ ocdev hello world
    Hello, world!
    $

Commands `ocdevhello-COMMAND` are called from the git directory.

Commands `.ocdevhello-COMMAND` should prepare environment by their own.

Bash scripts inherit a bunch of tools from `ocdev`:

  * oc, openshift, ... - tools from OpenShift's binary directory.
  * ocdefault - runs oc tool as system:admin in default namespace.
  * oadm - runs oadm as system:admin.
  * warn "message" - prints a warning message to stderr.
  * fatal "message" - prints a warning message and exits.
  * ocdevutil-init
  * ocdevutil-docker-init
  * ocdevutil-main ".ocdevcommandname-" "ocdevcommandname-" "$@" - prepare environment and run a command.

  * ocdevutil-commands - ...
  * ocdevutil-remove-image
  * ocdevutil-build-image-cleanup
  * ocdevutil-build-image

### In any language

Create an executable file named `ocdev-COMMAND` in your PATH directory. For example:

    $ mkdir ~/bin && export PATH="$PATH:$HOME/bin"
    $ cat >~/bin/ocdev-hello-world <<EOF
    #!/usr/bin/env python
    print("Hello, Python!")
    EOF
    $ chmod +x ~/bin/ocdev-hello-world
    $ ocdev hello-world
