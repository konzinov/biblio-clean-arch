module Biblio
  module Catalogue
    module UseCases
      class UseCase
        extend Dry::Initializer

        def execute(request_model, presenter = nil); end
      end
    end
  end
end
