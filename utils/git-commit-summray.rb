require 'pry'

require_relative './parse-github-contributions'
require_relative './parse-gitlab-contributions'

filepath_gitlab = "#{ENV["HOME"]}/Documents/notebook/tmp/tmp-gitlab.svg"
result_gitlab = GitlabContribCalendarParser.new.run(filepath_gitlab).map{|hash| hash[:data_count]}.sum

filepath_github = "#{ENV["HOME"]}/Documents/notebook/tmp/tmp-github.svg"
result_github = GithubContribCalendarParser.new.run(filepath_github).map{|hash| hash[:data_count]}.sum

puts <<~EOF
2021 commit summary:
  gitlab: #{result_gitlab} \t commits
  github: #{result_github} \t commits
EOF

