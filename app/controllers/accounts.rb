# frozen_string_literal: true

StewardAlfred::App.controllers :accounts do
  set :protect_from_csrf, false

  before do
    authorize!
  end

  get :index, with: :id do
    halt 501
  end

  post :index do
    Services::CreateAccount.new(
      name: params[:name],
      kind: params[:kind],
      total: params[:total]
    ).execute
    status 201
  rescue StandardError => e
    logger.error(e.message)
    status 500
  end
end
