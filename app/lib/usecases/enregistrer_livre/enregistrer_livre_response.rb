module UseCases
  class EnregistrerLivreResponse < Response
    option :livre, default: proc { nil }
    option :errors, default: proc { {} }
  end
end
