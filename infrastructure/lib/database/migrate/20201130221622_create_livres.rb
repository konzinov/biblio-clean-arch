# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :livres do
      primary_key :id
      column :titre, String, null: false
      column :auteur, String, null: false
      column :nb_pages, Integer, null: false
      column :date_publication, Date
    end
  end
end
