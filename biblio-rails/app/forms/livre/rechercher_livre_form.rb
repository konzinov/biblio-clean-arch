class Livre::RechercherLivreForm
  include ActiveModel::Model
  extend Dry::Initializer

  param :titre
end
