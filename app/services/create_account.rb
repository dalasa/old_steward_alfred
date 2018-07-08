# frozen_string_literal: true

module Services
  # Service that creates accounts
  class CreateAccount
    def initialize(name:, kind:, total:)
      @name = name
      @kind = kind
      @total = total
    end

    def execute
      account = Account.new(name: @name, kind: @kind, total: @total)
      account.save
    end
  end
end
