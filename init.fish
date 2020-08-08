function __fish_print_aws_profiles -d 'Prints a list of AWS profiles' -a select
  set -q AWS_CONFIG_FILE; or set AWS_CONFIG_FILE "$HOME/.aws/config"
  command sed -n 's/^\[profile \(.*\)\]/\1/p' "$AWS_CONFIG_FILE"
end
