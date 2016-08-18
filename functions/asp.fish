function asp --description 'Switches AWS profile' --argument 'aws_profile'
  if test -z "$aws_profile"
    if test -z "$AWS_DEFAULT_PROFILE"
      echo "No profile set"
    else
      asp "$AWS_DEFAULT_PROFILE"
      echo "$AWS_DEFAULT_PROFILE"
    end
  else
    if not fgrep -q "[profile $aws_profile]" ~/.aws/config
      echo "No such profile"
    else
      set -l access_key (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"aws_access_key_id\") { print \$3 }}" ~/.aws/credentials)

      if test -z "$access_key"
        set -l role_arn (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"role_arn\") { print \$3 }}" ~/.aws/credentials)
        set -l source_profile (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"source_profile\") { print \$3 }}" ~/.aws/credentials)
        set -l json (aws sts assume-role --profile "$source_profile" --role-arn "$role_arn" --role-session-name "$aws_profile")

        set -gx AWS_ACCESS_KEY_ID (echo $json | jq -r '.Credentials.AccessKeyId')
        set -gx AWS_SECRET_ACCESS_KEY (echo $json | jq -r '.Credentials.SecretAccessKey')
        set -gx AWS_SESSION_TOKEN (echo $json | jq -r '.Credentials.SessionToken')
        set -gx AWS_SECURITY_TOKEN "$AWS_SESSION_TOKEN"
      else
        set -gx AWS_ACCESS_KEY_ID "$access_key"
        set -gx AWS_SECRET_ACCESS_KEY (awk "/\[$aws_profile\]/,/^\$/ { if (\$1 == \"aws_secret_access_key\") { print \$3 }}" ~/.aws/credentials)
        set -e AWS_SESSION_TOKEN
        set -e AWS_SECURITY_TOKEN
      end

      set -gx AWS_DEFAULT_REGION (awk "/\[profile\ $aws_profile\]/,/^\$/ { if (\$1 == \"region\") { print \$3 }}" ~/.aws/config)
      set -gx AWS_DEFAULT_PROFILE "$aws_profile"
    end
  end
end
