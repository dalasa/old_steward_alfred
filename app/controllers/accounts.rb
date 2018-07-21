# frozen_string_literal: true

StewardAlfred::App.controllers :accounts do
  set :protect_from_csrf, false

  before do
    authorize!
    @request_data = Oj.load(request.body.read, symbol_keys: true)
  end

  get :index, with: :id do
    halt 501
  end

  post :index do
    account = Services::CreateAccount.new(
      name: @request_data[:name],
      kind: @request_data[:kind],
      total: @request_data[:total]
    ).execute
    status 201
    Oj.dump(account.attributes)
  rescue StandardError => e
    logger.error(e.message)
    status 500
  end
end
