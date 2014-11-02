root = exports ? this


jQueryDocumentSelectors = () ->

  #For any anchor link, we can smoothscroll it by adding a .smoothscroll to its classes
  $('a[href^="#"].smoothscroll').on('click', (e) ->
    e.preventDefault()
    target = this.hash
    $target = $(target)
    $('html, body').stop().animate({
        'scrollTop': $target.offset().top
      }, 500, 'swing', ->
        window.location.hash = target
    )
  )


  popupCenter = (url, width, height, name) ->
    left = (screen.width / 2) - (width / 2)
    top = (screen.height / 2) - (height / 2)
    window.open(url, name,
      "menubar=no,toolbar=no,status=no,width=" + width + ",height=" + height + ",toolbar=no,left=" + left + ",top=" + top);
  # all links with the data-popup attribute use javascript to render in a new window
  # optional height and width parameters, as well as a name
  $('a[data-popup]').click((e) ->
    height = $(this).data('popup-options-height') || '400'
    width = $(this).data('popup-options-width') || '600'
    name = $(this).data('popup-name') || '_blank'
    popupCenter($(this).attr('href'), width, height, name)
    e.stopPropagation()
    false
  );

  #set up the toggle for the modal signup vs. signin links
  modal = $('#registration_modal')
  $('#sign_up_switcher a').click((e) ->
    show = '.signin'
    remove = '.signup'
    if this.classList.contains('signin')
      show = remove
      remove = '.signin'

    show = modal.find(show)
    remove = modal.find(remove)

    remove.each(() ->
      $(this).addClass('hidden')
    )
    show.each(() ->
      $(this).removeClass('hidden')
    )

    #copy the values for email/password between the two forms
    #this is so that if someone starts a signin when they really meant to sign up, they don't have to reenter it
    # we only want to copy from the form being hidden, to the form being shown.
    show.find('form').each(() ->
      remove_form = remove.find('form')
      $(this).find('input.email').val(remove_form.find('input.email').val())
      $(this).find('input.password').val(remove_form.find('input.password').val())
    )
  )

  # set up the bootstrapvalidators for the forms in the modal
  # the actual details for the validation is in the html itself
  modal.find('.validated-form').each(() ->
    $(this).bootstrapValidator({
      excluded: [':disabled', ':hidden', ':not(:visible)'],
      feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
      },
      live: 'enabled',
      message: 'This value is not valid',
      submitButtons: 'button[type="submit"]',
      trigger: null,
      container: 'popover'
    })
  )

$(document).ready(jQueryDocumentSelectors)


# Javascript from the Solid theme for their portfolio gallery
root.solidPortfolio = () ->
  "use strict"
  $container = $('.portfolio')
  $items = $container.find('.portfolio-item')
  portfolioLayout = 'fitRows'

  if ($container.hasClass('portfolio-centered'))
    portfolioLayout = 'masonry'

  refreshWaypoints = () ->
    setTimeout((() ->)
    , 1000)

  $container.isotope({
    filter: '*',
    animationEngine: 'best-available',
    layoutMode: portfolioLayout,
    animationOptions: {
      duration: 750,
      easing: 'linear',
      queue: false
    },
    masonry: {
    }
  }, refreshWaypoints())
  $('nav.portfolio-filter ul a').on('click', () ->
    selector = $(this).attr('data-filter')
    $container.isotope({filter: selector}, refreshWaypoints())
    $('nav.portfolio-filter ul a').removeClass('active')
    $(this).addClass('active')
    false
  );

  getColumnNumber = () ->
    winWidth = $(window).width()
    columnNumber = 1

    if (winWidth > 1200)
      columnNumber = 5
    else if (winWidth > 950)
      columnNumber = 4
    else if (winWidth > 600)
      columnNumber = 3
    else if (winWidth > 400)
      columnNumber = 2
    else if (winWidth > 250)
      columnNumber = 1
    columnNumber

  setColumns = () ->
    winWidth = $(window).width()
    columnNumber = getColumnNumber()
    itemWidth = Math.floor(winWidth / columnNumber)

    $container.find('.portfolio-item').each(() ->
      $(this).css({
        width: itemWidth + 'px'
      })
    )

  setPortfolio = () ->
    setColumns()
    $container.isotope('reLayout')

  $container.imagesLoaded(() ->
    setPortfolio()
  )

  $(window).on('resize', () ->
    setPortfolio()
  )
