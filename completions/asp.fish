function __fish_print_aws_profiles -d 'Prints a list of AWS profiles' -a select
  command sed -n "s/^\[\(.*\)\]/\1/p" ~/.aws/credentials
end

complete -c asp -f -a "(__fish_print_aws_profiles)"
