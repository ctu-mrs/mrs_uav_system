# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd $MY_PATH

docker build -f ./debian -t ctumrs/mrs_uav_system_debian:latest .
