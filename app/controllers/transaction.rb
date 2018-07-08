# frozen_string_literal: true

StewardAlfred::App.controllers :transaction do
  set :protect_from_csrf, false

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

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   "Maps to url '/foo/#{params[:id]}'"
  # end

  # get '/example' do
  #   'Hello world!'
  # end
end
