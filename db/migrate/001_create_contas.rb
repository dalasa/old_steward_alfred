# frozen_string_literal: true

Sequel.migration do
  up do
    create_table :contas do
      primary_key :id
      String :nome, size: 50
      String :tipo
      Float :total
    end
  end

  down do
    drop_table :contas
  end
end
