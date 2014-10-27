root = exports ? this

popupCenter = (url, width, height, name) ->
  left = (screen.width / 2) - (width / 2)
  top = (screen.height / 2) - (height / 2)
  window.open(url, name,
      "menubar=no,toolbar=no,status=no,width=" + width + ",height=" + height + ",toolbar=no,left=" + left + ",top=" + top);

jQueryDocumentSelectors = () ->
  $('a[data-popup]').on('click', (e) ->
    height = $(this).data('popup-options-height') || '400'
    width = $(this).data('popup-options-width') || '600'
    name = $(this).data('popup-name') || '_blank'
    popupCenter($(this).attr('href'), width, height, name)
    e.stopPropagation()
    false
  );

$(document).ready(jQueryDocumentSelectors)

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
    masonry:{
    }
  }, refreshWaypoints())
  $('nav.portfolio-filter ul a').on('click', () ->
    selector = $(this).attr('data-filter')
    $container.isotope({ filter: selector }, refreshWaypoints())
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
