# ocdev

```
$ ocdev
usage: ocdev <command>

Available commands:
  bash-completion     Print the bash-completion script
  cleanup             Empty Docker and remove half of your system
  env                 Display the commands to set up the environment
  exec                Run a program from the directory with OpenShift binaries
  godoc               Run godoc for the package in the current directory
  login-as-developer  Login as the developer user
  login-as-pruner     Login as the pruner user
  oadm                Run openshift admin as the system:admin user
  oc                  Run oc from the current source tree
  ocdefault           Run oc command as the system:admin user in the default namespace
  start-router        Start the router
  test-end-to-end     Build images and run end-to-end tests

Commands for components:
  openshift   Manage the OpenShift server
  prometheus  Manage Prometheus
  registry    Manage the integrated Docker registry

Usage examples:
  ocdev cluster build
  ocdev openshift start --loglevel=4
  ocdev registry up

  ocdev registry update
```

## Extending

Create an executable file in ./snippets/ directory.

You can add a text section in the file

```
OCDEV USAGE: [-v] <arguments>
OCDEV HELP: a short help message

Below the HELP line you can write a longer description for your command.
OCDEV END
```
