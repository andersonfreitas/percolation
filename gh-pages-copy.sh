#!/bin/bash
# git co gh-pages
mkdir -p gh-pages/assets/css/
mkdir -p gh-pages/assets/js/libs/

cp dist/release/index.css gh-pages/assets/css/
cp dist/release/require.js gh-pages/assets/js/libs/
cp index.html gh-pages/
