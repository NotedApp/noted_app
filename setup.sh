#!/bin/bash

echo
echo "--- setting up pre-commit hook ---"

chmod +x pre-commit
cd .git/hooks
ln -s ../../pre-commit pre-commit

echo "--- set up pre-commit hook ---"
echo

exit 0
