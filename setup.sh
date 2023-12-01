#!/bin/bash

chmod +x pre-commit
cd .git/hooks
ln -s ../../pre-commit pre-commit

exit 0
