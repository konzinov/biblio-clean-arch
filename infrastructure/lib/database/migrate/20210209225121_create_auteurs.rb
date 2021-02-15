# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :auteurs do
      primary_key :id
      column :nom, String, null: false
      column :uuid, String, size: 50, null: false, default: Sequel.function(:uuid_generate_v4)
    end
  end
end
