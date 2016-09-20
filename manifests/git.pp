# Built-in puppet enterprise git server
class psquared::git(
    $repo_path = '/var/lib/psquared',
    $control_repo = 'r10k-control',
    $supplemental_repos = [],
    $authorised_keys = [],
    $admin_key = present,
    $admin_user = 'psquared',
) {
  
  $control_repo_path = "${repo_path}/${control_repo}"
  $ssh_path = "${repo_path}/.ssh"
  $hook_filename = "hooks/post-receive"

  File {
    owner => $admin_user,
    group => $admin_user,
    mode  => '0755',
  } 

  file { "/etc/puppetlabs/r10k/r10k.yaml":
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/r10k.yaml.erb"),
  }

  sudo::conf { 'admins_r10k':
    priority => 99,
    content  => "${admin_user} ALL=(pe-puppet) NOPASSWD: /opt/puppetlabs/puppet/bin/r10k",
  }

  sudo::conf { 'admins_curl':
    priority => 99,
    content  => "${admin_user} ALL=(pe-puppet) NOPASSWD: /bin/curl",
  }

  file { $repo_path:
    ensure => directory,
  }

  vcsrepo { $control_repo_path:
    ensure   => bare,
    provider => git,
    user     => $admin_user,
  }

  file { "${control_repo_path}/${hook_filename}":
    ensure   => file,
    mode     => '0755',
    source   => "puppet:///modules/${module_name}/post-receive",
  }

  # admin key :)
  user { $admin_user:
    ensure  => $admin_key,
    home    => $repo_path,
  }

  $ssh_keyname = "psquared@${fqdn}"
  include sshkeys

  sshkeys::install_keypair { $ssh_keyname: 
    ensure  => $admin_key,
    ssh_dir => $ssh_path,
  }

  # fixme - need to update sshkeys to allow removal
  sshkeys::known_host { $ssh_keyname: 
    ssh_dir => $ssh_path,
  }

  # fixme - grant access to the account to other users
  sshkeys::authorize { $admin_user:
    ensure          => $admin_key,
    authorized_keys => [$ssh_keyname],
    ssh_dir         => $ssh_path,
  }
}
