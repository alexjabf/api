class ApplicationController < ActionController::API
  include Response
  include Authenticate
  include SerialisableResource
end
