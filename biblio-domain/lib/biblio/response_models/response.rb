module Biblio::ResponseModels
  
  class Response
    extend Dry::Initializer
    
    option :errors, default: proc { {}}
    
    def success?
      errors.empty?
    end
    
    def failure?
      !success?
    end
    
    def self.build(**args)
      new(**args)
    end
    
  end
end