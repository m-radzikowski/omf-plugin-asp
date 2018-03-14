<img src="https://cdn.rawgit.com/oh-my-fish/oh-my-fish/e4f1c2e0219a17e2c748b824004c8d0b38055c16/docs/logo.svg" align="left" width="144px" height="144px"/>

#### asp

> A plugin for [Oh My Fish][omf-link].

[![MIT License](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)](/LICENSE)
[![Fish Shell Version](https://img.shields.io/badge/fish-v2.2.0-007EC7.svg?style=flat-square)](https://fishshell.com)
[![Oh My Fish Framework](https://img.shields.io/badge/Oh%20My%20Fish-Framework-007EC7.svg?style=flat-square)](https://www.github.com/oh-my-fish/oh-my-fish)

<br/>

Enables quick switching between AWS profiles. Supports both hard-coded keys and role assumption. Works with the [aws](https://github.com/oh-my-fish/plugin-aws) plugin by [@sagebind](https://github.com/sagebind).


## Prerequisites

- [jq](https://stedolan.github.io/jq/)
- [AWS CLI](https://aws.amazon.com/cli/)
- AWK


## Install

```fish
$ omf install git@github.com:sanyer/plugin-asp.git
```

```fish
$ fisher install sanyer/plugin-asp
```


## Usage

```fish
$ asp <aws_profile> [region]
```


Sets `$AWS_ACCESS_KEY_ID` and `$AWS_SECRET_ACCESS_KEY` environment variables to
the corresponding values from `~/.aws/credentials`. If keys are not listed in the
profile, attempts to assume the profile's `role_arn` provided in `~/.aws/config` file
and uses the returned keys.
Also sets `$AWS_DEFAULT_REGION` and `$AWS_DEFAULT_PROFILE`.
The optional region value can be used if you wish to override the default region
configured in your `~/.aws/config` file.

`~/.aws/credentials` and `~/.aws/config` reference: [AWS CLI Configuration Variables](https://docs.aws.amazon.com/cli/latest/topic/config-vars.html)

```fish
$ agp
Profile: <aws_profile>
Region: <region>
```

Echoes `$AWS_DEFAULT_PROFILE` and `AWS_DEFAULT_REGION`.


## Example configuration

```ini
~/.aws/credentials

[default]
aws_access_key_id = <ACCESS_KEY>
aws_secret_access_key = <SECRET_KEY>
```

```ini
~/.aws/config

[default]
output = json
region = us-east-1

[prod]
output = json
region = us-east-1
role_arn = arn:aws:iam::<ACCOUNT_NUMBER>:role/<PROD_ROLE_NAME>
source_profile = default

[stage]
output = json
region = us-east-1
role_arn = arn:aws:iam::<ACCOUNT_NUMBER>:role/<STAGE_ROLE_NAME>
source_profile = default
```


## Caveats

- Role-based credentials expire after one hour.


# License

[MIT][mit] © [Michael Goodness][author] et [al][contributors]


[mit]:            https://opensource.org/licenses/MIT
[author]:         https://github.com/mgoodness
[contributors]:   https://github.com/mgoodness/plugin-asp/graphs/contributors
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
