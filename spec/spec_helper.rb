$: << File.expand_path('../lib', File.dirname(__FILE__))
require 'wildcard_matchers'

require "pry"

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
end
