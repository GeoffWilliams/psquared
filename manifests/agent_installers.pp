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
    $install_osx_agents     = false,
){

  # prevent timeout errors
  Pe_staging::File {
    timeout => 1800, # 30 mins
  }

  if $install {
    # Just install everything - this list can be generated with the command:
    # fgrep class  /opt/puppetlabs/puppet/modules/pe_repo/manifests/platform/*.pp -h | sed 's/class/include/g' | sed 's/(//g'

    include pe_repo::platform::aix_53_power
    include pe_repo::platform::aix_61_power
    include pe_repo::platform::aix_71_power

    include pe_repo::platform::el_4_i386
    include pe_repo::platform::el_4_x86_64
    include pe_repo::platform::el_5_i386
    include pe_repo::platform::el_5_x86_64
    include pe_repo::platform::el_6_i386
    include pe_repo::platform::el_6_x86_64
    include pe_repo::platform::el_7_x86_64

    include pe_repo::platform::solaris_10_i386
    include pe_repo::platform::solaris_10_sparc
    include pe_repo::platform::solaris_11_i386
    include pe_repo::platform::solaris_11_sparc

    include pe_repo::platform::debian_7_amd64
    include pe_repo::platform::debian_7_i386
    include pe_repo::platform::debian_8_amd64
    include pe_repo::platform::debian_8_i386


    include pe_repo::platform::fedora_23_i386
    include pe_repo::platform::fedora_23_x86_64
    include pe_repo::platform::fedora_24_i386
    include pe_repo::platform::fedora_24_x86_64
    include pe_repo::platform::fedora_25_i386
    include pe_repo::platform::fedora_25_x86_64

    include pe_repo::platform::sles_11_i386
    include pe_repo::platform::sles_11_x86_64
    include pe_repo::platform::sles_12_x86_64


    include pe_repo::platform::ubuntu_1204_amd64
    include pe_repo::platform::ubuntu_1204_i386
    include pe_repo::platform::ubuntu_1404_amd64
    include pe_repo::platform::ubuntu_1404_i386
    include pe_repo::platform::ubuntu_1604_amd64
    include pe_repo::platform::ubuntu_1604_i386
    include pe_repo::platform::ubuntu_1610_amd64
    include pe_repo::platform::ubuntu_1610_i386


    include pe_repo::platform::windows_i386
    include pe_repo::platform::windows_x86_64
  }

  if $install_osx_agents {
    include pe_repo::platform::osx_1011_x86_64
    include pe_repo::platform::osx_1010_x86_64
    include pe_repo::platform::osx_109_x86_64
  }
}
