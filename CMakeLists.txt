cmake_minimum_required(VERSION 3.5)
project(mrs_uav_system)

set(CATKIN_DEPENDENCIES
    cmake_modules
    rospy
  )

find_package(catkin REQUIRED COMPONENTS
  ${CATKIN_DEPENDENCIES}
  )

catkin_package(
  CATKIN_DEPENDS ${CATKIN_DEPENDENCIES}
  )
