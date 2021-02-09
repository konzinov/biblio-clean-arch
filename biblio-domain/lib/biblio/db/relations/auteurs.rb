require 'rom-sql'

module Biblio
  module Db
    module Relations
      class Auteurs < ROM::Relation[:sql]
        schema(:auteurs, infer: true)

        def nom_like(nom_like)
          where { nom.like("#{nom_like}%") }
        end
      end
    end
  end
end
