module Biblio
  module Presenters
    class AfficherLivresPresenter < Presenter
      def present(afficher_livre_response)
        livres = afficher_livre_response.livres.map do |livre|
          view_model::Livre.new(Domain::Entities::Livre.dry_initializer.attributes(livre))
        end

        view_model.new(resume_nb_livres(livres), livres)
      end

      def view_model
        ViewModels::AfficherLivresViewModel
      end

      private
      def resume_nb_livres(livres)
        @resume_nb_livres ||= if livres.empty?
                          'Aucun livre présent'
                        else
                          "#{livres.size} Livres"
                        end
      end
    end
  end
end