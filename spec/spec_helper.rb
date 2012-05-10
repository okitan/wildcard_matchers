$: << File.expand_path('../lib', File.dirname(__FILE__))
require 'wildcard_matchers'

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each {|f| require f }

require "pry"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
end
