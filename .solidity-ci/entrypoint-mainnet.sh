#!/bin/bash
set -xe

if [ $SOLIDITY-CI_BRANCH == 'master' ] ; then
  eval "$(ssh-agent -s)"
  ssh-add
  # your choice of framework
  truffle deploy
  rsync -rq --delete --rsync-path="mkdir -p mainnet_deployments && rsync" \
  $SOLIDITY-CI_BUILD_DIR/public concourse-ci@<ip>:
else
  echo "Not deploying, since this branch isn't master."
fi
