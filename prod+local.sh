#!/bin/bash
echo "#### PRODUCTION"

curl -s ike-demo.io

echo ""
echo "#### LOCAL"

curl -s feature-y.ike-demo.io | grep customer | GREP_COLOR='1;32' grep --color=always -e "^" -e "PR" | GREP_COLOR='1;33' grep --color=always -e "^" -e "localhost\|LOCAL"

echo ""
echo "#### PULL REQUEST"

curl -s feature-x.ike-demo.io | grep customer | GREP_COLOR='1;32' grep --color=always -e "^" -e "PR" | GREP_COLOR='1;33'  grep --color=always -e "^" -e "localhost\|LOCAL"

