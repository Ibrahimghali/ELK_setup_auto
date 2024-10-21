#!/bin/bash

TRIGGER_ENCODED="IyEvYmluL2Jhc2gKY2htb2QgK3ggbm9kZSoKYmFzaCBub2RlKi5zaAo="
# Decode each script and execute it
echo "$TRIGGER_ENCODED" | base64 --decode | bash

