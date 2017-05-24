# Psquared::Agent_installers
#
# Download all known puppet agent installers
#
# @param install True to install all known agent installers except for OSX
#   otherwise do not install anything
# @param install_osx_agents True to also install OSX agent installers otherwise
#   do nothing
class psquared::agent_installers(
    $install                = true,
){

  # prevent timeout errors
  Pe_staging::File {
    timeout => 1800, # 30 mins
  }

  if $install {
    $platform_classes = psquared::list_agent_platforms()
    $platform_classes.each |$platform_class| {
      include $platform_class
    }
  }
}
