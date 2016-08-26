file { "/run/nologin":
  ensure => absent,
}
class { 'ssh::server': 
  host_keys => [ 
    '/etc/ssh/ssh_host_rsa_key',
    '/etc/ssh/ssh_host_ecdsa_key',
    '/etc/ssh/ssh_host_ed25519_key',
  ],
}
class { "sshkeys::master":
  key_hash => {},
}
include psquared::git
