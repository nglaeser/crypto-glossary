#!/bin/sh

### stash unstaged changes
STASH_NAME="pre-commit-$(date +%s)"
git stash save -q --keep-index $STASH_NAME

### do the stuff
# look for _latex.md files in all subdirectories of src
for f in $(find src -type f -name '*_latex.md'); do 
  # get the subdirectory name (remove 'src/' prefix)
  srcdir=$(dirname $f)
  outdir=${srcdir#src}
  outdir=${outdir#/}

  outfile=$(basename -s _latex.md $f).md
  # check if outdir is not empty
  if [ -n "$outdir" ]; then
    # create subdirectory/ies if not present
    mkdir -p $outdir

    # add path to outfile name
    outfile=$outdir/$outfile
  fi
  markdown-math-gh-compiler $f -o $outfile
  # example 
  # markdown-math-gh-compiler src/README_latex.md -o README.md
done
### stage the updates
git add .

### pop the stash to return repo to previous condition
STASHES=$(git stash list)
if [[ $STASHES == "$STASH_NAME" ]]; then
  git stash pop -q
fi
