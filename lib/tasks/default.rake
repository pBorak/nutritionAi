if %w[development test].include? Rails.env
  require "rubocop/rake_task"
  RuboCop::RakeTask.new

  task(:default).clear.enhance(
    [
      "rubocop",
      "brakeman:run",
      "db:environment:set",
      "db:test:prepare",
      "spec",
      "immigrant:check_keys",
    ],
  )
end
