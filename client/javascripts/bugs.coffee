Template.bugsList.helpers
  hasBugs: ->
    Bugs.find().count() > 0
  bugItems: ->
    Bugs.find({}, {sort: {vote_count: -1,created_at: 1}})


Template.bugStatus.helpers
  currentStatus: (status) ->
    @status is status

Template.bugStatus.events
  'click .item-status label:not(.active)': (e, doc) ->
    updateStatus = ""
    switch $(e.currentTarget).data 'status'
      when 'success' then updateStatus = 'complete'
      when 'danger' then updateStatus = 'incomplete'
      when 'warning' then updateStatus = 'wip'
    if @_id
      Bugs.update(@_id, {$set: {status: updateStatus}})
    else
      clicked = $(e.currentTarget)
      active = clicked.closest('.item-status').find('.active')
      status = active.data 'status'
      active.toggleClass("active btn-#{status}").addClass 'btn-default'
      status = clicked.data 'status'
      clicked.toggleClass "btn-default btn-#{status}"

Template.bugItem.helpers
  type: ->
    _.titleize(_.humanize(@type))
  currentStatus: (status) ->
    @status is status
  created_at: ->
    moment(@created_at).format("MMM DD, YYYY hh:mm:ss A")

Template.createBug.rendered = ->
  $('#bug-type').select2
    placeholder: "What's wrong?"
  $('#bugDescription').wysiwyg().on 'blur', (e) ->
    html = $(@).html()
    $('#hiddenDescription').val(html)


Template.createBug.events
  'click :submit': (e, doc) ->
    if $(e.currentTarget).attr('name') is 'add_another'
      Session.set('create_action', 'add_another')
    else
      Session.set('create_action', 'exit')
  'submit form': (e, doc) ->
    createBug e, doc, (e, doc) ->
      if Session.get('create_action') is 'exit'
        Router.go('bugs', {appName: Session.get('currentApp')})
      else if Session.get('create_action') is 'add_another'
        $(e.target).find('#bugDescription').html("")
        $(e.target).find('#hiddenDescription').val("")


createBug = (e, doc, callback) ->
  e.preventDefault()
  os = []
  browser = []
  $(e.target).find('[name="os"]:checked').each (index, el) ->
    os.push(el.value)
  $(e.target).find('[name="browser"]:checked').each (index, el) ->
    browser.push(el.value)
  bug =
    app: Session.get('currentAppId')
    type: $(e.target).find('#bug-type').val()
    os: os
    browser: browser
    description: $(e.target).find('#hiddenDescription').val()
    status: "incomplete"
    vote_count: 0
    created_by_user_id: Meteor.userId()
    created_by_username: Meteor.user().username
  Meteor.call 'getServerTime', (e,r) ->
    if r
      bug.created_at = r
      Bugs.insert(bug)
  callback(e, doc)


Template.editBug.helpers
  selectedType: (type) ->
    @type is type
  checkedOS: (os) ->
    _.include(@os, os)
  checkedBrowser: (browser) ->
    _.include(@browser, browser)

Template.editBug.events
  'submit form': (e, doc) ->
    e.preventDefault()
    currentBug = Session.get('currentBug')
    os = []
    browser = []
    $(e.target).find('[name="os"]:checked').each (index, el) ->
      os.push(el.value)
    $(e.target).find('[name="browser"]:checked').each (index, el) ->
      browser.push(el.value)
    bug =
      app: Session.get('currentAppId')
      type: $(e.target).find('#bug-type').val()
      os: os
      browser: browser
      description: $(e.target).find('#hiddenDescription').val()
    Bugs.update(currentBug, {$set: bug})
    Router.go('bugs', {appName: Session.get('currentApp')})
  'click .delete': (e, doc) ->
    e.preventDefault()
    if confirm("Are you sure? This will delete the bug and its comments forever.")
      currentBugId = Session.get('currentBug')
      Meteor.call 'removeBug', currentBugId, (error) ->
        if error
          throw error
        else
          Router.go('bugs', {appName: Session.get('currentApp')})

Template.editBug.rendered = ->
  $('#bug-type').select2
    placeholder: "What's wrong?"
  $('#bugDescription').wysiwyg().on 'blur', (e) ->
    html = $(@).html()
    $('#hiddenDescription').val(html)


Template.showBug.helpers
  type: ->
    _.titleize(_.humanize(@type))
  currentStatus: (status) ->
    @status is status
  created_at: ->
    moment(@created_at).format("MMM DD, YYYY hh:mm:ss A")
