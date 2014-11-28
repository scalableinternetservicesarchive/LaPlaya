adjust_body_margin_for_announcement = ->
  css = ''
  whole_body = $('#whole-body')
  if $('#announcements').length
    css = parseInt($('.navbar').css("height"))
  else
    whole_body.removeClass('announcement-margin')
  whole_body.css('margin-top', css);

$(document).ready(->
  $('#starburst-close').click(->
    $('#announcements').slideUp(
      step: adjust_body_margin_for_announcement,
      complete: ->
        $('#announcements').remove()
        adjust_body_margin_for_announcement()
    )
  )
)


$(window).resize(adjust_body_margin_for_announcement)
$(window).load(adjust_body_margin_for_announcement)
