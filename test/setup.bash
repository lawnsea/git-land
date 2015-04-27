# Ensure git finds the local git-land
project_root=`echo $(git rev-parse --show-toplevel)`
export PATH=$project_root:$PATH
