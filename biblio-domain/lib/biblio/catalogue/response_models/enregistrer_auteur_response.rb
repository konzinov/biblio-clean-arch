module Biblio
  module Catalogue
    module ResponseModels
      class EnregistrerAuteurResponse < Response
        option :auteur, default: proc { nil }
        option :errors, default: proc { {} }
      end
    end
  end
end
