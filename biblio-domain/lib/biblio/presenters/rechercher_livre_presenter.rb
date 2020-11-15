module Biblio
  module Presenters
    class RechercherLivrePresenter < Presenter
      def present(rechercher_livre_response)
        livres = rechercher_livre_response.livres.map do |livre|
          view_model::Livre.new(**Domain::Entities::Livre.dry_initializer.attributes(livre))
        end

        view_model.new(resume_nb_livres(livres), livres)
      end

      private

      def resume_nb_livres(livres)
        @resume_nb_livres ||= if livres.empty?
                                'Aucun livre trouvé'
                              else
                                "#{livres.size} Livres"
                              end
      end

      def view_model
        ViewModels::RechercherLivreViewModel
      end
    end
  end
end
