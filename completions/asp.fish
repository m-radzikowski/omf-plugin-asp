function __fish_print_aws_profiles --description 'Print a list of AWS profiles' --argument 'select'
  command sed -n 's/^\[\(.*\)\]/\1/p' ~/.aws/credentials
end

complete --command asp --no-files --arguments '(__fish_print_aws_profiles)'
