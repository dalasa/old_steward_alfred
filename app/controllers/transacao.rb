# frozen_string_literal: true

StewardAlfred::App.controllers :transacao do
  set :protect_from_csrf, false

  post :index do
    transacao = Services::CriaTransacao.new(
      nome_conta: params[:nome_conta],
      descricao: params[:descricao],
      valor: params[:valor],
      tipo: params[:tipo],
      tags: params[:tags],
      data_transacao: params[:data_transacao]
    ).executa
    status 201
    Oj.dump(transacao.attributes)
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
