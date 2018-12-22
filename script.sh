#!/bin/bash

set -e

function main {
  for rev in `revision`; do
    echo "`number_of_lines` `commit_description`"
  done
}
function revision {
  git rev-list --reverse HEAD
}

function number_of_lines {
    git ls-tree -r $rev |
    awk '{print $3}' |
    xargs git show |
    wc -l
}

function commit_description {
  git log --oneline -1 $rev
}
main
