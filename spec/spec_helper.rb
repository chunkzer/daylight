$:.unshift File.expand_path('../../lib', __FILE__)

# Simplecov must be loaded before environment
require File.expand_path('spec/config/simplecov_rcov')

# load the dummy rails environment
require File.expand_path("../dummy/config/environment.rb",  __FILE__)

require 'rspec/rails'
require 'rspec/autorun'

# Make sure WebMock is disabled
# -- is used by Daylight::Mock to route requests to the user's web application
#    but it wrecks havoc with FakeWeb
WebMock.disable!

# Load additional rspec configuration files first
Dir.glob(File.expand_path('../config/**/*.rb', __FILE__)).each { |f| require f }

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir.glob(File.expand_path('../support/**/*.rb', __FILE__)).each { |f| require f }

RSpec.configure do |config|
  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # clean up after every test
  config.after(:each) do
    FakeWeb.clean_registry
  end
end
