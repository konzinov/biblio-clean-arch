module UseCases
  class EnregistrerAuteurRequest
    extend Dry::Initializer

    option :nom
  end
end
