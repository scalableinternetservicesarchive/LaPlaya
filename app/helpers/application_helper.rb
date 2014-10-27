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
    elsif 'notice' == type
      'alert-info'
    elsif 'timedout' == type
      nil
    else
      "alert-#{type}"
    end
  end

  def controller_classes
    current_path = ''
    controller_path.split('/').map { |x| (current_path.empty?) ? current_path = x : current_path += '-' + x }.join(' ')
  end

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'active' : ''
    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  def nav_dropdown(dropdown_text, &block)
    content = capture(&block)
    class_name = content.index('active').nil? ? 'dropdown' : 'dropdown active'
    content_tag(:li, class: class_name) do
      (link_to '#', class: 'dropdown-toggle', 'data-toggle' => 'dropdown' do
         (dropdown_text +
        content_tag(:b, class: 'caret') do

        end).html_safe
      end) +
      content_tag(:ul, class: 'dropdown-menu', &block)
    end
  end
end
