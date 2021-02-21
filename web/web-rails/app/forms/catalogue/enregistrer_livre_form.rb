module Catalogue
  class EnregistrerLivreForm
    include ActiveModel::Model
    extend Dry::Initializer

    option :titre, optional: true
    option :auteur, optional: true
    option :nb_pages, optional: true
    option :date_publication, optional: true

    def enregistrer_livre_request
      UseCases::EnregistrerLivreRequest.new(**self.class.dry_initializer.attributes(self))
    end
  end
end
