module Entities
  class Livre
    include Dry::Equalizer(:titre, :uuid)
    extend Dry::Initializer

    option :uuid, { default: proc { SecureRandom.uuid } }
    option :titre
    option :auteur
    option :nb_pages, default: proc { 0 }, optional: true
    option :date_publication, optional: true
  end
end
