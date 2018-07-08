# frozen_string_literal: true

StewardAlfred::App.controllers :account do
  set :protect_from_csrf, false
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

  get :index do
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
