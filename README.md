[![Build Status](https://travis-ci.org/GeoffWilliams/declarativesystems.svg?branch=master)](https://travis-ci.org/declarativesystems/psquared)
# psquared

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with psquared](#setup)
    * [What psquared affects](#what-psquared-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with psquared](#beginning-with-psquared)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

PSquared brings additional features and an easier UX for users of Puppet Enterprise by supporting:
* Download of all known agent installer repositories
* Built in git server with pre-configured SSH access
* Automatic configuration of Code Manager
* Automatic Code Manager token creation and installation


## Usage

Most classes will need to be loaded using the `class` resource syntax in order to pass the appropriate class defaults, eg:

```puppet
class { "foo:bar":
  param1 => "value1",
  param2 => "value2",
}
```

Parameters, where available, are documented inside the individual classes.  See [Reference section](#reference).

### Git Server
#### Change the master branch to be production
```shell
git clone ssh://psquared@PUPPETMASTER.HOST.NAME/var/lib/psquared/r10k-control/
git symbolic-ref HEAD refs/heads/production
git push origin production
```


## Reference
Reference documentation is generated directly from source code using [puppet-strings](https://github.com/puppetlabs/puppet-strings).  You may regenerate the documentation by running:

```shell
bundle exec puppet strings
```

Or you may view the current [generated documentation](https://rawgit.com/GeoffWilliams/psquared/master/doc/index.html).

The documentation is no substitute for reading and understanding the module source code, and all users should ensure they are familiar and comfortable with the operations this module performs before using it.

## Limitations
* RHEL 6/7 only
* Not supported by Puppet, Inc.
* Not all classes are fully functional!  Use only those with accompanying spec tests


## Development

PRs accepted :)

## Testing
This module supports testing using [PDQTest](https://github.com/GeoffWilliams/pdqtest).


Test can be executed with:

```
bundle install
bundle exec pdqtest all
```

See `.travis.yml` for a working CI example
