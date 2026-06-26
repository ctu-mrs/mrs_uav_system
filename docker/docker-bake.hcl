# Input variables with default values
variable "PPA_VARIANT" { default = "unstable" }
variable "BASE_IMAGE" { default = "ctumrs/ros_jazzy:latest" }
variable "STABLE_TAG" { default = formatdate("YY_MM_DD", timestamp()) }
variable "PLATFORM" { default = "linux/amd64" }

# Grouping targets allows you to trigger both with a single command
group "default" {
  targets = ["mrs_uav_system", "mrs_uav_system_full"]
}

# ==========================================
# TARGET 1: Core System
# ==========================================
target "mrs_uav_system" {
  context    = "./mrs_uav_system"
  dockerfile = "Dockerfile"
  platforms  = ["${PLATFORM}"]

  args = {
    BASE_IMAGE  = "${BASE_IMAGE}"
    PPA_VARIANT = "${PPA_VARIANT}"
  }

  # Conditional Tagging for Core
  tags = PPA_VARIANT == "stable" ? [
    "ctumrs/mrs_uav_system:${PPA_VARIANT}",
    "ctumrs/mrs_uav_system:${PPA_VARIANT}_${STABLE_TAG}"
  ] : [
    "ctumrs/mrs_uav_system:${PPA_VARIANT}"
  ]
}

# ==========================================
# TARGET 2: Full System
# ==========================================
target "mrs_uav_system_full" {
  context    = "./mrs_uav_system_full"
  dockerfile = "Dockerfile"
  platforms  = ["${PLATFORM}"]

  args = {
    PPA_VARIANT = "${PPA_VARIANT}"
  }

  # Conditional Tagging for Full
  tags = PPA_VARIANT == "stable" ? [
    "ctumrs/mrs_uav_system_full:${PPA_VARIANT}",
    "ctumrs/mrs_uav_system_full:${PPA_VARIANT}_${STABLE_TAG}"
  ] : [
    "ctumrs/mrs_uav_system_full:${PPA_VARIANT}"
  ]

  # Makes the Dockerfile use the local build result of target "mrs_uav_system"
  contexts = {
    "ctumrs/mrs_uav_system:${PPA_VARIANT}" = "target:mrs_uav_system"
  }
}
