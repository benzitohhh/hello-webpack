#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

# Check out gh-pages branch
git checkout gh-pages

# Pull master into it
git reset --hard master

# Compile
npm install
npm run compile

# Move app files to top level
mv app/* ./

# Delete any junk
rm -rf node_modules
rm -rf package.json
rm -rf src
rm -rf webpack.config.js
rm -rf deploy.sh

# Commit and force push
git add *
git commit -a -m 'update'
git push -f

# Switch back to master
git checkout master

# Site code should now be at https://github.com/<user>/<project>/tree/gh-pages
# And should be live at https://<user>github.com/<project>