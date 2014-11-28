root = exports ? this


jQueryDocumentSelectors = () ->
  root.solidPortfolio()
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
  )

  #set up the toggle for the modal signup vs. signin links
  modal = $('#registration_modal')
  switchToClass = (klass, populate = true) ->
    classes = ['signin', 'signup', 'finish-signup']
    classes.splice(classes.indexOf(klass), 1)
    classes = classes.map((str) ->
      '.' + str
    ).join(',')
    from_form = false
    to_form = false
    temp = false
    if (klass == 'signup')
      to_form = modal.find('.signup>form')
      temp = modal.find('.signin>form')
    else if (klass == 'signin')
      to_form = modal.find('.signin>form')
      temp = modal.find('.signup>form')

    if temp && temp.is(':visible')
      from_form = temp


    modal.find(classes).each(()->
      unless $(this).hasClass(klass)
        $(this).addClass('hidden')
    )
    modal.find('.' + klass).each(()->
      $(this).removeClass('hidden')
    )

    if from_form && populate
      to_form.each(->
        email_selector = 'input[name="user[email]"]'
        password_selector = 'input[name="user[password]"]'
        $(this).find(email_selector).val(from_form.find(email_selector).val())
        $(this).find(password_selector).val(from_form.find(password_selector).val())
        validator = $(this).data('bootstrapValidator')
        if validator
          validator.validate()
      )

  root.switchSigninModalToClass = switchToClass

  #reset modal when hiding/showing
  modal.on('show.bs.modal', (e) ->
    switchToClass('signin')
    modal.find('form').each(->
      this.reset()
    )
  )
  modal.find('#cancel-signup').click(->
    switchToClass('signup')
    modal.find('.finish-signup form')[0].reset()
  )

  $('#sign_up_switcher a').click((e) ->
    if this.classList.contains('signin')
      switchToClass('signup')
    else if this.classList.contains('signup')
      switchToClass('signin')
  )

  # set up the bootstrapvalidators for the forms in the modal
  # the actual details for the validation is in the html itself
  modal.find('#signup-email-form').bootstrapValidator({
    excluded: [':disabled', ':hidden', ':not(:visible)'],
    feedbackIcons: {
      valid: 'glyphicon glyphicon-ok',
      invalid: 'glyphicon glyphicon-remove',
      validating: 'glyphicon glyphicon-refresh'
    },
    live: 'enabled',
    message: 'This value is not valid',
    submitButtons: '#email-signup-button',
    trigger: null,
    container: 'popover',
    fields: {
      'user[email]': {
        validators: {
          notEmpty: {
            message: 'Your email is required and can\'t be empty'
          },
          emailAddress: {
            message: 'The input is not a valid email address'
          },
          different: {
            field: 'user[password]',
            message: 'Your username and password can\'t be the same as each other'
          },
          remote: {
            url: '/users/check_email',
            name: 'email',
            delay: 250
          }
        }
      },
      'user[password]': {
        validators: {
          notEmpty: {
            message: 'Your password is required and can\'t be empty'
          },
          different: {
            field: 'user[email]',
            message: 'Your username and password can\'t be the same as each other'
          },
          remote: {
            url: '/users/check_password',
            name: 'password',
            delay: 250
          },
          identical: {
            field: 'user[password]',
            message: 'Password and confirmation do not match'
          }
        }
      },
      'user[password_confirmation]': {
        validators: {
          identical: {
            field: 'user[password]',
            message: 'Password and confirmation do not match'
          }
        }
      }
    }
  }).on('error.form.bv', (e) ->
    e.preventDefault();
    $form = $(e.target)
    validator = $form.data('bootstrapValidator')
    $icon = $form.find('div.form-group.has-error i')[0]
    if ($icon)
      $($icon).popover('show')
  )

  root.validateFinishForm = ->
    modal.find('#finish-signup-form').bootstrapValidator({
      excluded: [':disabled', ':hidden', ':not(:visible)'],
      feedbackIcons: {
        valid: 'glyphicon glyphicon-ok',
        invalid: 'glyphicon glyphicon-remove',
        validating: 'glyphicon glyphicon-refresh'
      },
      live: 'enabled',
      message: 'This value is not valid',
      submitButtons: '#finish-signup-button',
      trigger: null,
      container: 'popover',
      fields: {
        'user[username]': {
          validators: {
            notEmpty: {
              message: 'Your username is required and can\'t be empty'
            },
            remote: {
              url: '/users/check_username',
              name: 'username',
              delay: 250
            }
          }
        }
      }
    }).on('submit', (e) ->
      $form = $(e.target)
      validator = $form.data('bootstrapValidator')
      validator.validate()
      unless validator.isValid()
        e.preventDefault();
        return false
      $form[0].submit()
      return true
    ).on('error.form.bv', (e) ->
      e.preventDefault();
      e.stopImmediatePropagation();
      $form = $(e.target)
      validator = $form.data('bootstrapValidator')
      $icon = $form.find('div.form-group.has-error i')[0]
      if ($icon)
        $($icon).popover('show')
    )
  root.validateFinishForm()


$(document).ready(jQueryDocumentSelectors)




#Javascript from the Solid theme for their portfolio gallery
root.solidPortfolio = () ->
  "use strict"
  $('.portfolio').each( ->
    $container = $(this)

    $container.imagesLoaded(->
      $container.isotope({
        itemSelector: '.portfolio-item',
        masonry: {
          columnWidth: '.grid-sizer'
        }
      })
    )

  )

