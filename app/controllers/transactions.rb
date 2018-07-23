# frozen_string_literal: true

StewardAlfred::App.controllers :transactions do
  set :protect_from_csrf, false

  before do
    authorize!
    @request_data = Oj.load(request.body.read, symbol_keys: true)
  end

  get :index, with: :id do
    Transaction.find(params[:id]).to_json
  rescue ActiveRecord::RecordNotFound
    halt(404, 'Not found')
  end

  post :index do
    validation = TransactionHelper::CreateValidator.call(@request_data)
    transaction = Services::CreateTransaction.new(validation.output).execute
    status 201
    Oj.dump(transaction.attributes)
  rescue StandardError => e
    logger.error(e.message)
    status 500
  end

  patch :index, with: :id do
    validation = TransactionHelper::UpdateValidator.call(@request_data)
    Services::UpdateTransaction.new(transaction_id: params[:id], attributes: validation.output).execute
    status 200
  end

  delete :index, with: :id do
    Services::DeleteTransaction.new(transaction_id: params[:id]).execute
    status 200
  end
end
