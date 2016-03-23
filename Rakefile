task :localtest do
  sh 'foodcritic -t ~FC003 -t ~FC034 .'
  sh 'rspec --color -f d ./recipes/'
  sh 'rubocop'
end

task :bump do
  sh 'knife spork bump ${PWD##*/} -o ..'
end
