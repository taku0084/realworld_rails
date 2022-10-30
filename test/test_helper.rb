ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  include Committee::Rails::Test::Methods

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def response_body
    JSON.parse(response.body)
  end

  def committee_options
    @committee_options ||= {
      schema_path: Rails.root.join('api', 'openapi.yml').to_s,
      query_hash_key: 'rack.request.query_hash',
      parse_response_by_content_type: false,
      prefix: "/api"
    }
  end
end
