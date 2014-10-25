module ApplicationHelper
  def full_title(page_title)
    if page_title.empty?
      'LaPlaya'
    else
      page_title
    end
  end

  def alert_class_for_type(type)
    if %w(alert error).include?(type)
      'alert-danger'
    elsif %w(alert error).include?(type)
      'alert-success'
    elsif 'timedout' == type
      nil
    else
      "alert-#{type}"
    end
  end

  def controller_classes
    current_path = ''
    controller_path.split('/').map{|x| (current_path.empty?) ? current_path = x : current_path += '-' + x  }.join(' ')
  end
end
