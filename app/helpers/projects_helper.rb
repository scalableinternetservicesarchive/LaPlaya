module ProjectsHelper

  def heart_link
    if can? :create, ProjectLike
      if @liked
        link_to unlike_project_path(@project), method: :delete do
          '<i class="fa fa-heart text-danger"></i>'.html_safe
        end
      else
        link_to like_project_path(@project), method: :post do
          '<i class="fa fa-heart-o pull-right"></i>'.html_safe
        end
      end
    else
      '<i class="fa fa-heart-o pull-right"></i>'.html_safe
    end
  end

  def comment_return_link
    if request.path != project_path(@project)
      link_to('View all comments', project_path(@project))
    end
  end

  def tag_cloud(tags, classes)
    max = [1,tags.sort_by(&:count).last.count].max
    tags.take(10).each do |tag|
      index = tag.count.to_f / max * (classes.size-1)
      yield(tag, classes[index.round])
    end
  end

end
