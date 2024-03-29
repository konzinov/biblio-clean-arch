require 'test_helper'

class LivreDbRepositoryTest < Minitest::Test
  def setup
    @repo = Database::Container.resolve(:livre_repository)
    @livre_attrs = { titre: 'Le vieux nègre et la médaille', auteur: 'Bernard Dadié',
                     date_publication: DateTime.now, id: 1 }
    @livre = Entities::Livre.new(**@livre_attrs)
  end

  def test_save
    livre = Entities::Livre.new(**@livre_attrs.merge(date_publication: nil))
    refute_nil @repo.save(livre)
  end

  def teardown
    @repo.clear!
  end

  def test_all
    @repo.save(@livre)
    assert_equal [@livre], @repo.all
  end

  def test_find
    @repo.save(@livre)
    assert_equal @livre, @repo.find(1)
  end

  def test_find_by_title
    @repo.save(@livre)
    assert_includes @repo.find_by_title('Le vieux nègre et la médaille'), @livre
  end

  def test_count
    @repo.save(@livre)
    assert_equal 1, @repo.count
  end
end
