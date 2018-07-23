# frozen_string_literal: true

module Services
  # Service that creates accounts
  class CreateAccount
    def initialize(name:, kind:, balance:)
      @name = name
      @kind = kind
      @balance = balance
    end

    def execute
      Account.create!(name: @name, kind: @kind, balance: @balance)
    end
  end
end
