# frozen_string_literal: true

guard 'rspec', cmd: 'bundle exec rspec' do
  # Watch for changes to any fabricators and run their associated specs
  watch(%r{^spec/fabricators/(.+)_fabricator\.rb$}) { 'spec' }

  # Watch for changes to any specs and run them
  watch(%r{^spec/(.+)_spec\.rb$})

  # Watch for changes to spec_helper and run all specs
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }

  # Watch for changes to files in app/ and run their associated specs
  watch(%r{^app/(.+)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }

  # Watch for changes to selected files in app/graphql/ and run all graphql specs
  watch(%r{^app/graphql/(.+)(sbase_|authorized_)(.+)\.rb$}) { 'spec/graphql' }

  # Watch for changes to files in lib/ and run their associated specs
  watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }

  # Watch for changes to application_controller and run all controller specs
  watch('app/controllers/application_controller.rb') { 'spec/controllers' }
end
