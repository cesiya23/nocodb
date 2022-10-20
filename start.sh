DIR="$(pwd)"

build_sdk () {
  # build nocodb-sdk
  cd "${DIR}"/packages/nocodb-sdk || exit
  npm install
  npm run build
}

prepare_backend () {
  # build backend - runs on port 4000
  cd "${DIR}"/packages/nocodb || exit
  npm install
  #npm run watch:run:dev
  #pm2 start "npm run watch:run:dev" --name backend
}

build_backend () {
  build_sdk
  prepare_backend
  npm run build
}

build_frontend () {
  # build frontend - runs on port 3000
  cd "${DIR}"/packages/nc-gui || exit
  npm install
  npm run dev
  #pm2 start "npm run dev" --name frontend
}

update_heap () {
  node -e 'console.log(v8.getHeapStatistics().heap_size_limit/(1024*1024))'
  #set NODE_OPTIONS=--max_old_space_size=8192
  export NODE_OPTIONS=--max-old-space-size=8192
}

start_backend () {
  cd "${DIR}"/packages/nocodb || exit
  #export NODE_OPTIONS=--max-old-space-size=8192
  #npm run watch:run:dev
  cross-env  PORT=4000 NC_DISABLE_TELE1=true EE=true nodemon -e ts,js -w ./src -x "ts-node src/run/docker --log-error --project tsconfig.json"
}

start_seed () {
  #git clone
  npm install --legacy-peer-deps
  npm run start
}

build_backend