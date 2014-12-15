# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ProjectsController = Paloma.controller('Projects');

ProjectsController.prototype.show = () ->
  $(document).ready(->
    # We need to relayout the isotope when the panel is uncollapsed
    comments = $('#comments')
    current_user_id = comments.data('current-user-id')
    if current_user_id == 'superuser'
      comments.find('.show-logged-in').each(->
        $(this).removeClass('hidden')
      )
      comments.find('.show-for-owner').each(->
        $(this).removeClass('hidden')
      )
    else if current_user_id
      comments.find('.show-logged-in').each(->
        $(this).removeClass('hidden')
      )
      comments.find('.comment[data-owner-id="'+current_user_id+'"]').find('.show-for-owner').each(->
        $(this).removeClass('hidden')
      )
  )
