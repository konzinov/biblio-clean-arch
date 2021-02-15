module UseCases
  class EnregistrerAuteurResponse < Response
    option :auteur, default: proc { nil }
    option :errors, default: proc { {} }
  end
end
