# frozen_string_literal: true

# Helper methods defined here can be accessed in any controller or view in the application

# main module reference
module StewardAlfred
  # main app class reference
  class App
    # TransactionHelper module for app - I don't know if it will be necessary
    # TODO maybe I will delete it after
    module TransactionHelper
      # def simple_helper_method
      # ...
      # end
    end

    helpers TransactionHelper
  end
end
