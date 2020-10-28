module Biblio
  module Presenters
    class Presenter
      extend Dry::Initializer
      
      param :format
      param :response_model
      
      def present
      end
    end
  end
end