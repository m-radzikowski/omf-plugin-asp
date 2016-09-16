function __fish_print_aws_profiles -d 'Print a list of AWS profiles' -a 'select'
  command sed -n 's/^\[\(.*\)\]/\1/p' ~/.aws/credentials
end

complete --command asp --no-files --arguments '(__fish_print_aws_profiles)'
