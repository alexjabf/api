# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::API
  include Response
  include Authenticate
  include SerialisableResource
end
