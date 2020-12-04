require 'rom-sql'

module Biblio
  module Db
    module Relations
      class Livres < ROM::Relation[:sql]
        schema(:livres, infer: true)

        def titre_like(titre_like)
          where { titre.like("#{titre_like}%") }
        end
      end
    end
  end
end
