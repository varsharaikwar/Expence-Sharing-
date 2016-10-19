# Load the Rails application.
require_relative 'application'

if $0 == 'irb'
  require 'hirb'
  Hirb.enable
end

# Initialize the Rails application.
Rails.application.initialize!
