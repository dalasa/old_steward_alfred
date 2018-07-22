# frozen_string_literal: true

StewardAlfred::App.controllers :files do
  # upload with:
  # curl -v -F "data=@/path/to/filename"  http://localhost:4567/user/filename
  post :ofx do
    content_type :json
    ofx_file = params[:data][:tempfile]
    account_name = params[:account_name]
    transactions = Services::ImportTransactionsFromOFX.new(ofx_file, account_name).execute
    transactions.to_json
  end
end
