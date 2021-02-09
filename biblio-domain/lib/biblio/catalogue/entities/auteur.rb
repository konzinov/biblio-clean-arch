module Biblio
  module Catalogue
    module Entities
      class Auteur
        include Dry::Equalizer(:nom, :uuid)
        extend Dry::Initializer

        option :nom
        option :uuid, { default: proc { SecureRandom.uuid } }
      end
    end
  end
end
