require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'project must have a title and thumbnail' do
    project = Project.new title: nil, thumbnail: 'a thumbnail'
    assert project.invalid?

    project = Project.new title: 'a title', thumbnail: nil
    assert project.invalid?

    project = Project.new title: nil, thumbnail: nil
    assert project.invalid?

    project = Project.new title: 'a title', thumbnail: 'a thumbnail'
    assert project.valid?
  end

end
