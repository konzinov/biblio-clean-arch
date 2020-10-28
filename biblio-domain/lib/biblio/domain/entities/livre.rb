module Biblio::Domain::Entities
  class Livre
    extend Dry::Initializer
    include Dry::Equalizer(:titre)
    
    param :titre
    param :auteur
    param :nb_pages, default: proc { 0 }, optional: true
    param :date_publication, optional: true
  end
end