module Biblio
  module Domain
    module UseCases
      class UseCase
        extend Dry::Initializer

        def execute(request_model, presenter=nil)
        end
      end
    end
  end
end