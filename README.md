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
