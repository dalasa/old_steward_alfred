require 'spec_helper'

RSpec.describe "/conta" do
  describe '#post' do
    subject do
      post "/conta"
    end

    it "retorna 201" do
      subject
      expect(last_response.status).to eq 201
    end
  end
end
