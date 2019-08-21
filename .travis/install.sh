#!/bin/bash

set -e -x

cpanm --quiet --notest Module::Build

# Git branch to merge to or custom branch
WTSI_NPG_BUILD_BRANCH=${WTSI_NPG_BUILD_BRANCH:=$TRAVIS_BRANCH}
# WTSI NPG Perl repo dependencies
repos="perl-dnap-utilities"
for repo in $repos
do
  cd /tmp
  # Always clone master when using depth 1 to get current tag
  git clone --branch master --depth 1 ${WTSI_NPG_GITHUB_URL}/${repo}.git ${repo}.git
  cd /tmp/${repo}.git
  # Shift off master to appropriate branch (if possible)
  git ls-remote --heads --exit-code origin ${WTSI_NPG_BUILD_BRANCH} && git pull origin ${WTSI_NPG_BUILD_BRANCH} && echo "Switched to branch ${WTSI_NPG_BUILD_BRANCH}"
  cpanm --quiet --notest --installdeps . || find /home/travis/.cpanm/work -cmin -1 -name '*.log' -exec tail -n20  {} \;
  perl Build.PL
  ./Build
  ./Build install
done

cd "$TRAVIS_BUILD_DIR"
