# psquared::list_agent_platforms
#
# Scan the classes provided by pe_repo and produce an array strings containing
# all of the shipped pe_repo::platform classes for this PE release.  This solves
# the problem of having to keep psquared in sync with each PE release
Puppet::Functions.create_function(:'psquared::list_agent_platforms') do

  def list_agent_platforms()
    platform_classes = []

    Dir.glob("/opt/puppetlabs/puppet/modules/pe_repo/manifests/platform/*.pp").each { |f|
      puppet_classpart = File.basename(f).gsub(/\.pp$/,'')
      platform_classes << "pe_repo::platform::#{puppet_classpart}"
    }
    platform_classes
  end
end
