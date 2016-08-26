# Built-in puppet git server
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
  $hook_filename = ".git/hooks/post-receive"

  File {
    owner => $admin_user,
    group => $admin_user,
    mode  => '0755',
  } 

  file { $repo_path:
    ensure => directory,
  }

  vcsrepo { $control_repo_path:
    ensure   => present,
    provider => git,
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
  sshkeys::ssh_keygen{ $ssh_keyname:
    ensure => $admin_key,
  }

  sshkeys::install_keypair { $ssh_keyname: 
    ensure  => $admin_key,
    ssh_dir => $ssh_path,
    require => Sshkeys::Ssh_keygen[$ssh_keyname],
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
