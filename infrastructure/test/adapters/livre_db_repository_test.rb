require 'test_helper'

class LivreDbRepositoryTest < Minitest::Test
  def setup
    @repo = Database::Container.resolve(:livre_repository)
    @repo.save(Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié',
                                   date_publication: DateTime.now))
  end

  def test_all
    refute_empty @repo.all
    assert_equal 1, @repo.count
  end
end
