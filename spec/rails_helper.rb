# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'

require 'pry'
require 'vcr'
require 'webmock/rspec'

RSpec.configure do |config|
  config.define_derived_metadata(file_path: %r{/spec/components}) do |metadata|
    metadata[:type] = :view_component
  end

  config.fixture_path               = Rails.root.join('spec', 'fixtures')
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.file_fixture_path = 'spec/files'

  config.before(:each, type: :system) do
    driven_by(:rack_test)
  end

  config.define_derived_metadata(file_path: %r{/spec/components}) do |metadata|
    metadata[:type] = :view_component
  end

  config.include FactoryBot::Syntax::Methods
  config.include ActiveSupport::Testing::TimeHelpers
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true
end
