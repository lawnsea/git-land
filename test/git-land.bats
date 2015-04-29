load setup

# Usage
# -----------------------------------------------------------------------------
@test "invoking git-land with no arguments prints usage and exits" {
  run git land
  [ $status -ne 0 ]
  [[ "$output" =~ 'Usage: git land' ]]
}

@test "invoking git-land with three arguments prints usage and exits" {
  run git land foo bar applesauce
  [ $status -ne 0 ]
  [[ "$output" =~ 'Usage: git land' ]]
}

# General error conditions
# -----------------------------------------------------------------------------
@test "exits with an error if user doesn't confirm merge" {
  run bash -c "yes no | git land 123"
  [ $status -eq 1 ]
}

# When all options are fully specified
# -----------------------------------------------------------------------------
@test "'git land origin feature-branch:master' fast-forward merges feature branch on top of local master" {
  enter_repo "local"

  run bash -c "yes | git land origin feature-branch:master"
  [ $status -eq 0 ]

  run git log --pretty=format:"%s"
  [[ "${lines[0]}" =~ 'second feature commit' ]]
  [[ "${lines[1]}" =~ 'first feature commit' ]]
  [[ "${lines[2]}" =~ 'second master commit' ]]
  [[ "${lines[3]}" =~ 'first master commit' ]]
}

@test "'git land origin feature-branch:master' pushes local master to origin" {
  enter_repo "local"

  run bash -c "yes | git land origin feature-branch:master"
  [ $status -eq 0 ]

  local_log=`git log --pretty=format:"%h %s"`

  enter_repo "origin"
  origin_log=`git log --pretty=format:"%h %s"`

  [ "$origin_log" = "$local_log" ]
}
