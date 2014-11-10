module CommentsHelper
  def comment_return_link
    if request.path != project_path(@project)
      link_to("View all comments", project_path(@project))
    end
  end
end
