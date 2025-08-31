#!/usr/bin/bash

function we_are_in_git_work_tree {
    git rev-parse --is-inside-work-tree &> /dev/null
}
