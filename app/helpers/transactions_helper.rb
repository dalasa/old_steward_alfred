# frozen_string_literal: true

# Helper methods defined here can be accessed in any controller or view in the application

# TransactionHelper module for app
class TransactionHelper
  UpdateValidator = Dry::Validation.Params do
    required(:id).filled(:int?)
    optional(:description).filled(:str?)
    optional(:amount).filled(:float?)
    optional(:kind).filled(:str?)
    optional(:tags).filled(:array?)
    optional(:performed_at).filled(:date?)
    optional(:billing_date).filled(:date?)
  end

  CreateValidator = Dry::Validation.Params do
    required(:account_name).filled(:str?)
    required(:description).filled(:str?)
    required(:amount).filled(:float?)
    required(:kind).filled(:str?)
    required(:tags).filled(:array?)
    # TODO ajustar o campo para receber uma data: required(:performed_at).filled(:date?)
    required(:performed_at).filled(:str?)
  end
end
