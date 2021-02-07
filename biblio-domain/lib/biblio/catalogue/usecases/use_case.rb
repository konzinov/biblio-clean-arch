module Biblio
  module Catalogue
    module UseCases
      class UseCase
        extend Dry::Initializer

        def execute(request_model, presenter = nil); end

        protected

        def request_model; end

        def response_model; end
      end
    end
  end
end
