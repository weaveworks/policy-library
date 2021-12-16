package magalix.advisor.nodes.outdated_kernel_version

kernel_latest_versions := {
  "Amazon Linux 2": {
      "4.14":"4.14.193"
  },
  "Container-Optimized OS from Google": {
      "4.14":"4.14.174", 
      "4.19":"4.19.122", 
      "5.4":"5.4.49"
  },
  "default": {
      "4.4":"4.4.240", 
      "4.9":"4.9.240",
      "4.14":"4.14.202",
      "4.19":"4.19.152", 
      "5.4":"5.4.72",
      "5.8":"5.8.16",
      "5.9":"5.9.1"
  }
}

osImage := input.review.object.status.nodeInfo.osImage
      
image = osImage {
  kernel_latest_versions[osImage]
} else = "default" {
  not kernel_latest_versions[osImage]
}
  

kernel_version := regex.split("[-|+]", input.review.object.status.nodeInfo.kernelVersion)[0]
kernel_version_list := regex.split("[.]", kernel_version)


major_version := concat(".", [kernel_version_list[0], kernel_version_list[1]])
latest_kernel := kernel_latest_versions[image][major_version]

violation[result] {
  verify := semver.compare(kernel_version, latest_kernel)
  verify < 0
  
  result = {
    "issue detected": true,
    "osImage": osImage,
    "kernel_version": kernel_version,
    "latest_kernel": latest_kernel,
    "msg": "You are running an older version of the Linux kernel",
    "violating_key": "status.nodeInfo.kernelVersion"
    }
}