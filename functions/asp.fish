function asp -d 'Switches AWS profile' -a aws_profile region do_assume
  if test -z "$aws_profile"
    echo "Usage: asp <aws_profile> [region]"
    echo "Optional region flag to override default region"
    return 1
  end

  function ini_pattern -a section key
    echo '/^[[:blank:]]*\[[[:print:][:blank:]]*'$section'\]/,/\[/s/^[[:blank:]]*'$key'[[:blank:]]*=[[:blank:]]*//p'
  end

  set -e access_key
  set -e secret_key

  set -l access_key (sed -n (ini_pattern $aws_profile aws_access_key_id) $HOME/.aws/credentials)
  set -l secret_key (sed -n (ini_pattern $aws_profile aws_secret_access_key) $HOME/.aws/credentials)

  if test -z "$access_key" -o -z "$secret_key"
    set -l role_arn (sed -n (ini_pattern $aws_profile role_arn) $HOME/.aws/config)
    set -l source_profile (sed -n (ini_pattern $aws_profile source_profile) $HOME/.aws/config)

    if test -n "$role_arn" -a -n "$source_profile" -a -n "$do_assume"
      set -l json \
        (aws sts assume-role --profile "$aws_profile" --role-arn "$role_arn" \
          --role-session-name "$aws_profile" --output text \
          --query 'Credentials.[AccessKeyId,SecretAccessKey,SessionToken]' | tr '\t' ' ')

      set access_key (echo $json | cut -d' ' -f1)
      set secret_key (echo $json | cut -d' ' -f2)
      set session_token (echo $json | cut -d' ' -f3)
    end
  end

  set -gx AWS_ACCESS_KEY_ID "$access_key"
  set -gx AWS_SECRET_ACCESS_KEY "$secret_key"
  set -gx AWS_SESSION_TOKEN "$session_token"
  set -gx AWS_SECURITY_TOKEN "$AWS_SESSION_TOKEN"
  set -gx AWS_DEFAULT_PROFILE "$aws_profile"
  set -gx AWS_PROFILE "$aws_profile"

  set -U aws_profile "$aws_profile"

  if test -z "$region"
    if fgrep -qs "$aws_profile" $HOME/.aws/config
      set region (sed -n (ini_pattern $aws_profile region) $HOME/.aws/config)
    end
  end

  set -gx AWS_DEFAULT_REGION "$region"
end
