function asp -d 'Switches AWS profile' -a aws_profile region
  if test -z "$aws_profile"
    echo "Usage: asp <aws_profile> [region]"
    echo "Optional region flag to override default region"
    return 1
  end

  set -l access_key \
    (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"aws_access_key_id\") { print \$3 }}" \
      $HOME/.aws/credentials)
  set -l secret_key \
    (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"aws_secret_access_key\") { print \$3 }}" \
      $HOME/.aws/credentials)
  set -l session_token \
    (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"aws_session_token\") { print \$3 }}" \
      $HOME/.aws/credentials)

  if test -z "$access_key" -o -z "$secret_key"
    set -l role_arn \
      (awk "/$aws_profile/,/^\$/ { if (\$1 == \"role_arn\") { print \$3 }}" \
        $HOME/.aws/config)
    set -l source_profile \
      (awk "/$aws_profile/,/^\$/ { if (\$1 == \"source_profile\") { print \$3 }}" \
        $HOME/.aws/config)

    if test -n "$role_arn" -a -n "$source_profile"
      set -l json \
        (aws sts assume-role --profile "$source_profile" --role-arn "$role_arn" \
          --role-session-name "$aws_profile" --output json)

      set access_key (echo $json | jq -r '.Credentials.AccessKeyId')
      set secret_key (echo $json | jq -r '.Credentials.SecretAccessKey')
      set session_token (echo $json | jq -r '.Credentials.SessionToken')
    else
      echo "Invalid $aws_profile profile in $HOME/.aws/config"
      return 1
    end
  end

  set -gx AWS_ACCESS_KEY_ID "$access_key"
  set -gx AWS_SECRET_ACCESS_KEY "$secret_key"
  set -gx AWS_SESSION_TOKEN "$session_token"
  set -gx AWS_SECURITY_TOKEN "$AWS_SESSION_TOKEN"
  set -gx AWS_DEFAULT_PROFILE "$aws_profile"
  set -U aws_profile "$aws_profile"

  if test -z "$region"
    if fgrep -qs "$aws_profile" $HOME/.aws/config
      set region \
        (awk "/\[(profile[[:space:]]*)?$aws_profile\]/,/^\$/ { if (\$1 == \"region\") { print \$3 }}" \
          $HOME/.aws/config)
    end
  end

  set -gx AWS_DEFAULT_REGION "$region"
end
