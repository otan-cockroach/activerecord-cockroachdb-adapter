require "cases/helper_cockroachdb"

require "cases/helper"
require "models/post"
require "models/comment"
require "models/author"
require "models/rating"
require "models/categorization"

module ActiveRecord
  module CockroachDB
    class RelationTest < ActiveRecord::TestCase
      fixtures :posts

      def test_relation_with_annotation_includes_comment_in_to_sql
        post_with_annotation = Post.where(id: 1).annotate("foo")
        assert_match %r{= '1' /\* foo \*/}, post_with_annotation.to_sql
      end

      def test_relation_with_annotation_filters_sql_comment_delimiters
        post_with_annotation = Post.where(id: 1).annotate("**//foo//**")
        assert_match %r{= '1' /\* foo \*/}, post_with_annotation.to_sql
      end
    end
  end
end
