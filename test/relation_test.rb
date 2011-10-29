require File.expand_path("../helper", __FILE__)

module Sawyer
  class RelationTest < TestCase
    def test_builds_relation_from_hash
      hash = {:_href => '/users/1', :_method => 'post'}
      rel  = Sawyer::Relation.from_link(:self, hash)

      assert_equal :self,      rel.name
      assert_equal '/users/1', rel.href
      assert_equal :post,      rel.method
    end

    def test_builds_relations_from_hash_index
      index = {
        'self' => {:_href => '/users/1', :_method => 'post'}
      }

      rels = Sawyer::Relation.from_links(index)

      assert rel = rels[:self]
      assert_equal :self,      rel.name
      assert_equal '/users/1', rel.href
      assert_equal :post,      rel.method
    end
  end
end