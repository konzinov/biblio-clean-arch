module UseCases
  class EnregistrerLivreRequest
    extend Dry::Initializer
    option :titre
    option :auteur
    option :nb_pages
    option :date_publication
  end
end
