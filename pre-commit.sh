#!/bin/sh

### stash unstaged changes
STASH_MSG="pre-commit-$(date +%s)"
# `git stash save` is deprecated
git stash push --keep-index -m $STASH_MSG -q

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

  ### markdown-math-gh-compiler
  markdown-math-gh-compiler $f -o $outfile
  # example 
  # markdown-math-gh-compiler src/README_latex.md -o README.md

  ### embedmd 
  # TODO: adds an empty line at the end of the file
  embedmd $outfile > temp.md
  cat temp.md > $outfile
  rm temp.md
done
### stage the updates
git add .

### pop the stash to return repo to previous condition
git stash pop -q