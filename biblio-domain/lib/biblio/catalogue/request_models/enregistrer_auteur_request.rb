module Biblio
  module Catalogue
    module RequestModels
      class EnregistrerAuteurRequest
        extend Dry::Initializer

        option :nom
      end
    end
  end
end
