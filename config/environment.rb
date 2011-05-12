# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Etipitaka::Application.initialize!

config.gem "Chrononaut-no_fuzz", :source => "http://gems.github.com", :lib => "no_fuzz"
