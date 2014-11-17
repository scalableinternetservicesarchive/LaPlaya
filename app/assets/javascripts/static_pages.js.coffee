# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

StaticPagesController = Paloma.controller('StaticPages');

StaticPagesController.prototype.home = () ->
  $(document).ready(->
    # We need to relayout the isotope when the panel is uncollapsed
    $('.portfolio').on('shown.bs.collapse', ->
      $(this).isotope('layout')
    )
  )


StaticPagesController.prototype.solid = () ->
 $(document).ready((() ->
   solidPortfolio()
  ))
