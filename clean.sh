cleanNodeModules () {
  rm -rf node_modules #package-lock.json
  npm cache clean --force
  npm cache verify
}

cd "$(pwd)"/packages/nocodb-sdk || exit
cleanNodeModules
npm install
npm run build

cd "$(pwd)"/packages/nocodb || exit
cleanNodeModules
npm install
