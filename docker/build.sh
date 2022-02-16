# get the path to this script
MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

cd $MY_PATH

docker build -f with_linux_setup_modules -t ctumrs/mrs_uav_system_ls_modules:latest .
