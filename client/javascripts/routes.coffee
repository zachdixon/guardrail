Meteor.startup ->
  `(function(e,b){if(!b.__SV){var a,f,i,g;window.mixpanel=b;a=e.createElement("script");a.type="text/javascript";a.async=!0;a.src=("https:"===e.location.protocol?"https:":"http:")+'//cdn.mxpnl.com/libs/mixpanel-2.2.min.js';f=e.getElementsByTagName("script")[0];f.parentNode.insertBefore(a,f);b._i=[];b.init=function(a,e,d){function f(b,h){var a=h.split(".");2==a.length&&(b=b[a[0]],h=a[1]);b[h]=function(){b.push([h].concat(Array.prototype.slice.call(arguments,0)))}}var c=b;"undefined"!==
typeof d?c=b[d]=[]:d="mixpanel";c.people=c.people||[];c.toString=function(b){var a="mixpanel";"mixpanel"!==d&&(a+="."+d);b||(a+=" (stub)");return a};c.people.toString=function(){return c.toString(1)+".people (stub)"};i="disable track track_pageview track_links track_forms register register_once alias unregister identify name_tag set_config people.set people.set_once people.increment people.append people.track_charge people.clear_charges people.delete_user".split(" ");for(g=0;g<i.length;g++)f(c,i[g]);
b._i.push([a,e,d])};b.__SV=1.2}})(document,window.mixpanel||[]);
mixpanel.init("50bf43445362254d3d65316791cb5ef5");`
  if !!Meteor.userId()
    mixpanel.identify(Meteor.userId())
    Meteor.call 'trackUser', (e,r) ->
      if r
        mixpanel.people.set r
  mixpanel.track("Loaded app")

Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"

Router.onBeforeAction ->
    Meteor.startup ->
      window.scrollTo(0,0)
    routeName = @route.name
    if _.include(["tests", "settings", "create", "edit"], routeName)
      unless Meteor.user() or Meteor.loggingIn() then Router.go('home')
    if @params.appName isnt undefined
      if App.subs.apps.ready()
        Session.set('currentApp', @params.appName)
        Session.set('currentAppId', Apps.findOne({name: @params.appName})._id)
    else
      Session.set('currentApp', undefined)
      Session.set('currentAppId', undefined)

Router.map ->
  @route "home",
    path: "/"
  @route "tests",
    path: "/:appName/tests"
    template: "testsList"
    onBeforeAction: ->
      Session.set 'currentPage', 'tests'
      Session.set('statusFilter', 'all')
  @route "settings",
    path: "/:appName/settings"
    template: "settings"
    onBeforeAction: ->
      Session.set 'currentPage', 'settings'
  @route "create",
    path: "/:appName/create"
    template: "createTest"
    onBeforeAction: ->
      Session.set 'currentPage', 'tests'
  @route "edit",
    path: "/:appName/:_id/edit"
    template: "editTest"
    onBeforeAction: ->
      Session.set 'currentPage', 'tests'
      Session.set('currentTest', @params._id)
      unless Tests.findOne(@params._id) then Router.go('tests', {appName: @params.appName})
    data: ->
      Tests.findOne(Session.get('currentTest'))
  @route "show",
    path: "/:appName/:_id/show"
    template: "showTest"
    onBeforeAction: ->
      Session.set 'currentPage', 'tests'
      Session.set('currentTest', @params._id)
    data: ->
      Tests.findOne(Session.get('currentTest'))
  @route "bugs",
    path: "/:appName/bugs"
    template: "bugsList"
    onBeforeAction: ->
      Session.set 'currentPage', 'bugs'
  @route "createBug",
    path: "/:appName/bugs/create"
    template: "createBug"
    onBeforeAction: ->
      Session.set 'currentPage', 'bugs'
  @route "editBug",
    path: "/:appName/bugs/:_id/edit"
    template: "editBug"
    onBeforeAction: ->
      Session.set 'currentPage', 'bugs'
      Session.set 'currentBug', @params._id
      unless Bugs.findOne(@params._id) then Router.go('bugs', {appName: @params.appName})
    data: ->
      Bugs.findOne(Session.get('currentBug'))
  @route "showBug",
    path: "/:appName/bugs/:_id/show"
    template: "showBug"
    onBeforeAction: ->
      Session.set 'currentPage', 'bugs'
      Session.set 'currentBug', @params._id
    data: ->
      Bugs.findOne(Session.get('currentBug'))
