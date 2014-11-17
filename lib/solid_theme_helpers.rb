module SolidThemeHelpers

  def solid_portfolio(options = {}, &block)
    wrapper_options = {class: 'portfolio'}
    if options[:wrapper_options]
      wrapper_options.merge!(options[:wrapper_options])
    end
    content = capture(&block)
    content_tag :div, wrapper_options do
      concat content_tag :div, '', class: 'grid-sizer'
      concat content
    end
  end

  def solid_mouseover_image(text, thumb_url, &block)
    content = capture(&block)
    content_tag :div, class: 'he-wrap tpl6' do
      (
      concat image_tag thumb_url
      concat (content_tag :div, class: 'he-view' do
               content_tag :div, class: 'bg a0', data: {animate: 'fadeIn'} do
                 concat (content_tag :h3, class: 'a1', data: {animate: 'fadeInDown'} do
                          text
                        end)
                 concat content
               end
             end)
      )
    end
  end

  def solid_portfolio_item(text, thumb_url, image_url, link_url, lightbox_title = SecureRandom.hex(10))
    solid_portfolio_item_wrapper do
      solid_mouseover_image(truncate(text, length: 40), thumb_url) do
        concat (link_to image_url, class: 'dmbutton a2', data: {animate: 'fadeInUp', lightbox: lightbox_title} do
                 '<i class="fa fa-search"></i>'.html_safe
               end)
        concat (link_to link_url, class: 'dmbutton a2', 'data-animate' => 'fadeInUp' do
                 '<i class="fa fa-link"></i>'.html_safe
               end)
      end
    end
  end

  def solid_image_carousel(id, images, options = {})
    options.reverse_merge!({active: 0})
    wrapper_options = options[:wrapper_options] || {}
    wrapper_options.reverse_merge!(class: 'carousel slide', data: {ride: 'carousel'})
    wrapper_options[:id] = id
    content_tag :div, wrapper_options do
      concat solid_carousel_indicators(id, images, options)
      concat solid_carousel_inner(images, options)
    end
  end

  def sample_mouseover_images
    session['devise.auth_method']
  end

  private
  def solid_carousel_indicators(id, images, options)
    content_tag :ol, class: 'carousel-indicators' do
      (1..images.length).each_with_index do |v, i|
        __options = {data: {target: "##{id}", 'slide-to' => i.to_s}}
        if options[:active] == i
          __options[:class] = 'active'
        end
        concat content_tag(:li, nil, __options)
      end
    end
  end

  def solid_carousel_inner(images, options)
    content_tag :div, class: 'carousel-inner' do
      images.each_with_index do |v, i|
        classes = (i == options[:active]) ? 'item active' : 'item'
        concat (
                   content_tag :div, class: classes do
                     image_tag v, alt: ''
                   end
               )
      end
    end
  end

  def solid_portfolio_item_wrapper(wrapper_optipns = {}, &block)
    klass = 'portfolio-item'
    if wrapper_optipns[:class]
      klass = wrapper_optipns[:class]
    end
    content_tag :div, class: klass, &block
  end

end