Template.testsList.helpers
  testsReady: ->
    Session.get('testsReady')
  hasCategories: ->
    Categories.find().count() > 0
  hasTests: ->
    Tests.find().count() > 0

Template.testsList.rendered = ->
  Session.set('currentTest', '')

Template.testItems.rendered = ->
  $('body').scrollspy
    target: "#socialcompass-sidenav"
    offset: 100
  $('[data-spy="scroll"]').each ->
    $spy = $(@).scrollspy('refresh')

Template.testItems.helpers
  categories: ->
    Categories.find()


Template.testGroup.helpers
  hasTestItems: ->
    Tests.find({category: @_id}).count() > 0
  testItems: ->
    Tests.find({category: @_id}, {sort: {created_at: -1}})
  slug: ->
    _.slugify(@name)

Template.testItem.helpers
  currentStatus: (status) ->
    @status is status
  created_at: ->
    moment(@created_at).format("MMM DD, YYYY hh:mm:ss A")

      
Template.createTest.helpers
  categories: ->
    Categories.find()

Template.createTest.events
  'click :submit': (e, doc) ->
    if $(e.currentTarget).attr('name') is 'add_another'
      Session.set('create_action', 'add_another')
    else
      Session.set('create_action', 'exit')
  'submit form': (e, doc) ->
    createTest e, doc, (e, doc) ->
      if Session.get('create_action') is 'exit'
        Router.go('tests', {appName: Session.get('currentApp')})
      else if Session.get('create_action') is 'add_another'
        $(e.target).find('#testTitle').val("")
        $(e.target).find('#testDescription').val("")
      

createTest = (e, doc, callback) ->
  e.preventDefault()
  test =
    app: Session.get('currentAppId')
    category: $(e.target).find('#testCategory').val()
    status: $(e.target).find('.item-status :checked').val()
    title: $(e.target).find('#testTitle').val()
    description: $(e.target).find('#hiddenDescription').val()
  Meteor.call 'getServerTime', (e,r) ->
    if r
      test.created_at = r
      Tests.insert(test)
  callback(e, doc)

Template.createTest.rendered = ->
  $('#testCategory').select2
    placeholder: "Select category"
  $('#testDescription').wysiwyg().on 'blur', (e) ->
    html = $(@).html()
    $('#hiddenDescription').val(html)


Template.testStatus.helpers
  currentStatus: (status) ->
    if status is "untested" and @status is undefined then return true
    @status is status

Template.testStatus.events
  'click .item-status label:not(.active)': (e, doc) ->
    updateStatus = ""
    switch $(e.currentTarget).data 'status'
      when 'success' then updateStatus = 'passing'
      when 'danger' then updateStatus = 'failing'
      else updateStatus = 'untested'
    if @_id
      Tests.update(@_id, {$set: {status: updateStatus}})
    else
      clicked = $(e.currentTarget)
      active = clicked.closest('.item-status').find('.active')
      status = active.data 'status'
      active.toggleClass("active btn-#{status}").addClass 'btn-default'
      status = clicked.data 'status'
      clicked.toggleClass "btn-default btn-#{status}"

Template.editTest.helpers
  categories: ->
    Categories.find()
  currentCategory: (category) ->
    if Session.get('currentTest') then Tests.findOne(Session.get('currentTest')).category is category

Template.editTest.events
  'submit form': (e, doc) ->
    e.preventDefault()
    currentTest = Session.get('currentTest')
    test =
      app: Session.get('currentAppId')
      category: $(e.target).find('#testCategory').val()
      status: $(e.target).find('.item-status :checked').val()
      title: $(e.target).find('#testTitle').val()
      description: $(e.target).find('#hiddenDescription').val()
      created_at: Tests.findOne(currentTest).created_at
    Tests.update(currentTest, {$set: test})
    Router.go('tests', {appName: Session.get('currentApp')})
  'click .delete': (e, doc) ->
    e.preventDefault()
    if confirm("Are you sure? This will delete the test and its comments forever.")
      currentTestId = Session.get('currentTest')
      Tests.remove currentTestId, (error) ->
        unless error then Router.go('tests', {appName: Session.get('currentApp')})

Template.editTest.rendered = ->
  $('#testCategory').select2
    placeholder: "Select category"
  $('#testDescription').wysiwyg().on 'blur', (e) ->
    html = $(@).html()
    $('#hiddenDescription').val(html)

Template.showTest.helpers
  created_at: ->
    moment(@created_at).format("MMM DD, YYYY hh:mm:ss A")

