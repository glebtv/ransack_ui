require_relative 'spec_helper'

ENV['RAILS_ENV'] = 'test'

require 'combustion'
Combustion.initialize! :active_record, :action_controller, :action_view, :action_dispatch

require 'rspec/rails'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.before(:suite) do
    ActiveRecord::Schema.verbose = false
    load Rails.root.join('db/schema.rb').to_s

    intro = ('-' * 80)
    intro << "\n"
    intro << "- Ruby:        #{RUBY_VERSION}\n"
    intro << "- Rails:       #{Rails.version}\n"
    intro << ('-' * 80)
    RSpec.configuration.reporter.message(intro)
  end
end
