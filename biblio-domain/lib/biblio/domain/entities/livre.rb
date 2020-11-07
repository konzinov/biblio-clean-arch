module Biblio::Domain::Entities
  class Livre
    include Dry::Equalizer(:titre)
    extend Dry::Initializer
    
    param :titre
    param :auteur
    param :nb_pages, default: proc { 0 }, optional: true
    param :date_publication, optional: true
  end
end