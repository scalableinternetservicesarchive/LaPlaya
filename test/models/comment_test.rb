require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  test "comment should not save without a project" do
    comment = Comment.new text: "test"
    assert_not comment.save, "Saved comment without associating it with a project"
  end

  test "comment should have text length > 0" do
    comment = comments(:invalid)
    assert_not comment.save, "Created a comment with text length < 1"
  end

end
