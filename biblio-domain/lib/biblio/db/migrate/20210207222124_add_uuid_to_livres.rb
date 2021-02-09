# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table :livres do
      add_column :uuid, String, size: 50, null: false, default: Sequel.function(:uuid_generate_v4)
    end
  end
end
