require 'test_helper'

class LivreDbRepositoryTest < Minitest::Test
  def setup
    @repo = Database::Container.resolve(:livre_repository)
    @livre = Entities::Livre.new(titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié',
                                 date_publication: DateTime.now, id: 1)
    @repo.save(@livre)
  end

  def teardown
    @repo.clear!
  end

  def test_all
    assert_equal [@livre], @repo.all
  end

  def test_find
    assert_equal @livre, @repo.find(1)
  end

  def test_find_by_title
    assert_includes @repo.find_by_title('Le vieux nègre et la médaille'), @livre
  end

  def test_count
    assert_equal 1, @repo.count
  end
end
