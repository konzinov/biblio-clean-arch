module ViewModels
  class AfficherLivresViewModel < ViewModel
    extend Dry::Initializer
    param :resume_nb_livres
    param :livres, default: proc { [] }
    option :message, optional: true

    class Livre
      extend Dry::Initializer
      option :titre
      option :auteur
      option :nb_pages, default: proc { 0 }
      option :date_publication, default: proc { 'N/A' }
    end
  end
end
