ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec::Core::ExampleGroup.send(:include, RSpec::Matchers)

RSpec.configure do |config|
  config.color_enabled = true
  config.filter_run :focused => true
  config.run_all_when_everything_filtered = true
  config.alias_example_to :fit, :focused => true
  config.backtrace_exclusion_patterns << %r{vendor/gems/rspec}
  config.backtrace_exclusion_patterns << %r{vendor/bundler_gems}
  config.backtrace_exclusion_patterns << %r{\.rvm/gems}
  config.use_transactional_fixtures = true
end