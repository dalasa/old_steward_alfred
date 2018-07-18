# frozen_string_literal: true

require 'jwt'

# main module reference
module StewardAlfred
  # main app class reference
  class App
    # Authorization Helper for the application
    module AuthorizationHelper
      def authorize!
        options = { iss: ENV['JWT_ISSUER'], verify_iss: true, algorithm: 'HS256' }
        bearer = request.env['HTTP_AUTHORIZATION'].slice(7..-1)
        JWT.decode bearer, ENV['JWT_SECRET'], true, options
      rescue JWT::InvalidIssuerError, JWT::VerificationError
        halt 403, { 'Content-Type' => 'text/plain' }, ['Invalid token']
      end
    end

    helpers AuthorizationHelper
  end
end
