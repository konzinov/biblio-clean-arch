module Biblio::ResponseModels
  class RechercherLivreResponse < Response
  
    option :titre
    option :auteur
    option :nb_pages, default: proc { 0 }, optional: true
    option :date_publication, optional: true
  
  end
end