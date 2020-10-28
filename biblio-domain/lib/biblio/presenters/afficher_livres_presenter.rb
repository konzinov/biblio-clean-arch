module Biblio
  module Presenters
    class AfficherLivresPresenter < Presenter
      
      alias_method :afficher_livres_response, :response_model
      
      def present
        ViewModels::AfficherLivesViewModel
        
        new afficher_livres_response
      end
    end
  end
end