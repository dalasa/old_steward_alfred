require 'spec_helper'

RSpec.describe "StewardAlfred::  class App::TransacaoHelper" do
  pending "add some examples to (or delete) #{__FILE__}" do
    let(:helpers){ Class.new }
    before { helpers.extend StewardAlfred::  class App::TransacaoHelper }
    subject { helpers }

    it "should return nil" do
      expect(subject.foo).to be_nil
    end
  end
end
