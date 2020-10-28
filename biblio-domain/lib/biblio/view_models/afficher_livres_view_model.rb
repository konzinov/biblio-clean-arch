module Biblio
  module ViewModels
    class AfficherLivesViewModel < ViewModel
      extend Dry::Initializer
      
      param :livres, default: proc { [] }
      
      
      class Livre
        extend Dry::Initializer
        
        param :titre
        param :auteur
        param :nb_pages, default: proc { 0 }
        param :date_publication, default: proc {'N/A'}
      end
    end
  end
end