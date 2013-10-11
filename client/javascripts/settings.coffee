Template.appSettings.events
  'click .delete': ->
    appName = Session.get('currentApp')
    appId = Session.get('currentAppId')
    answer = prompt("Type #{appName} to confirm deletion of this app.")
    if answer is appName
      Apps.remove(appId)
      Categories.find({app: appId}).forEach (category) ->
        Categories.remove(category._id)
      Tests.find({app: appId}).forEach (test) ->
        Tests.remove(test._id)
      Router.go 'home'

Template.appSettings.rendered = ->
  $('.app-settings').editable
    selector: '.editable-click'
    type: 'text'
    mode: 'inline'
  $('a.app-name').unbind('save').on 'save', (e, params) ->
    oldName = @text
    newName = params.newValue
    Apps.update(Session.get('currentAppId'), {$set: {name: newName}})
    Router.go('home')