<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### asp

> A plugin for [Oh My Fish][omf-link].

[![MIT License][license-badge]](/LICENSE)
[![Fish Shell Version][fish-badge]](https://fishshell.com)
[![Oh My Fish Framework][omf-badge]][omf-link]

<br/>

Enables quick switching between AWS profiles.

## Prerequisites

- [AWS CLI](https://aws.amazon.com/cli/)
- AWK

## Install

```fish
$ omf install git@github.com:mgoodness/plugin-asp.git
```

## Usage

### Set profile

```fish
$ asp <aws_profile> [region]
```

Sets `$AWS_PROFILE` and `$AWS_DEFAULT_PROFILE` variables.  
The optional region value can be used if you wish to override the default region
configured for the profile.

### Get selected profile

```fish
$ agp
```

Echoes `$AWS_PROFILE` and `$AWS_DEFAULT_REGION`.

### Clear selected profile

```fish
$ acp
```

# License

[MIT][mit] © [Michael Goodness][author] et [al][contributors]


[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/mgoodness
[contributors]:   https://github.com/mgoodness/plugin-asp/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
[fish-badge]:     https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square
[omf-badge]:     https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square
