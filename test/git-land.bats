load setup

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
