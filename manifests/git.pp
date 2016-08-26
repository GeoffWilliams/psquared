# Built-in puppet git server
class psquared::git(
    $repo_path = '/var/lib/psquared',
    $control_repo = 'r10k-control',
    $supplemental_repos = [],
    $authorised_keys = [],
    $admin_key = present,
) {
  
  $control_repo_path = "${repo_path}/${control_repo}"
  $ssh_path = "${repo_path}/.ssh"
  $hook_filename = ".git/hooks/post-receive"

  File {
    owner => 'root',
    group => 'root',
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
  user { "psquared":
    ensure  => $admin_key,
    homedir => $repo_path,
  }

  $ssh_keyname = "psquared@${fqdn}"

  sshkeys::ssh_keygen{ $ssh_keyname:
    ensure => $admin_key,
  }

  sshkeys::install_keypair { $ssh_keyname: 
    ensure  => $admin_key,
    ssh_dir => $admin_key,
  }

  # fixme - need to update sshkeys to allow removal
  sshkeys::known_host { $ssh_keyname: 
    ssh_dir => $admin_key,
  }

}
