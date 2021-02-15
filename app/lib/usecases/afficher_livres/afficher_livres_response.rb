module UseCases
  class AfficherLivresResponse < Response
    param :livres, default: proc { [] }
  end
end
