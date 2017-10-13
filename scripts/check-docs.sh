#!/bin/sh
OCDEV=ocdev
COMMAND="$*"
RC=0

doc=$($OCDEV help $COMMAND | grep "^  " | grep -v "^  ocdev ")
commands=$($OCDEV commands $COMMAND)

for cmd in $commands; do
    if [ "$cmd" == "help" -o "$cmd" == "commands" ]; then
        continue
    fi
    if ! echo "$doc" | grep -F " $cmd " >/dev/null; then
        echo ocdev $COMMAND $cmd -- no documentation
        RC=1
    fi
    $0 $COMMAND $cmd
done

for cmd in $(echo "$doc" | cut -d " " -f 3); do
    if ! echo "$commands" | sed -e 's/^/ /;s/$/ /' | grep -F " $cmd " >/dev/null; then
        echo ocdev $COMMAND $cmd -- not implemented
    fi
done

exit $RC
