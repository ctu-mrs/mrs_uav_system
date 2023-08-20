# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd $MY_PATH

docker build -f ./1.5 -t ctumrs/mrs_uav_system:1.5 .
