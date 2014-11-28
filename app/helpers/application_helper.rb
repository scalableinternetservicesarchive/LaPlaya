module ApplicationHelper
  include SolidThemeHelpers
  def full_title(page_title)
    if page_title.empty?
      'LaPlaya'
    else
      page_title
    end
  end

  def alert_class_for_type(type)
    logger.debug "Processing flash of type #{type}"
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

  def nav_link(link_text, link_path, link_options = {})
    class_name = link_path && current_page?(link_path) ? 'active' : ''
    content_tag(:li, :class => class_name) do
      if link_path
        link_to link_text, link_path, link_options
      else
        content_tag(:a, link_text, link_options)
      end
    end
  end

  def nav_button(button_text, button_options = {})
    content_tag(:li) do
      button_tag button_text, button_options
    end
  end

  def nav_dropdown(dropdown_text, &block)
    dropdown_text ||= ''
    content = capture(&block)
    class_name = content.index('active').nil? ? 'dropdown' : 'dropdown active'
    content_tag(:li, class: class_name) do
      concat (link_to '#', class: 'dropdown-toggle', 'data-toggle' => 'dropdown' do
               concat dropdown_text
               concat content_tag(:b, nil, class: 'caret')
             end)
      concat content_tag(:ul, content, class: 'dropdown-menu')
    end
  end

  def force_login_helper
    if @force_show_signin || @force_show_signup || @force_show_finish
      script = '$(\'#registration_modal\').modal(\'show\');'
      if @force_show_signup
        script += 'switchSigninModalToClass(\'signup\', false);'
      elsif @force_show_finish
        script += 'switchSigninModalToClass(\'finish-signup\', false);'
      end
      content_for :one_time_script, javascript_tag("$(document).ready(function(){#{script}});")
    end
  end

  def new_user
    @new_user || User.new
  end

end
