# frozen_string_literal: true

StewardAlfred::App.controllers :transactions do
  set :protect_from_csrf, false

  get :index, with: :id do
    halt 501
  end

  post :index do
    transaction = Services::CreateTransaction.new(
      account_name: params[:account_name],
      description: params[:description],
      amount: params[:amount],
      kind: params[:kind],
      tags: params[:tags],
      transaction_date: params[:transaction_date]
    ).execute
    status 201
    Oj.dump(transaction.attributes)
  rescue StandardError => e
    logger.error(e.message)
    status 500
  end
end
