require 'test_helper'

class LivreTest < Minitest::Test
  def test_instantiate_livre
    # Given
    # When
    livre = Entities::Livre.new(titre: 'Question pour un champion', auteur: 'Julien', nb_pages: 120)

    # Then
    assert_equal 'Question pour un champion', livre.titre
    assert_equal 'Julien', livre.auteur
    assert_equal 120, livre.nb_pages
    refute_nil livre.uuid
  end

  def test_equalize_livre
    # Given
    uuid = SecureRandom.uuid

    # When
    pagne_noir = Entities::Livre.new(titre: 'Le Pagne Noir', auteur: 'Julien', nb_pages: 120, uuid: uuid)
    same_pagne_noir = Entities::Livre.new(titre: 'Le Pagne Noir', auteur: 'Julien', nb_pages: 120, uuid: uuid)
    other_pagne_noir = Entities::Livre.new(titre: 'Le Pagne Noir', auteur: 'Julien', nb_pages: 120, uuid: 'another_uuid')

    # Then
    refute_equal pagne_noir, other_pagne_noir
    assert_equal pagne_noir, same_pagne_noir
  end
end
