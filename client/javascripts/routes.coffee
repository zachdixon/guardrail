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
  layout: "layout"
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
  before: ->
    routeName = @context.route.name
    if _.include(["tests", "settings", "create", "edit"], routeName)
      unless Meteor.user() then Router.go('home')
    if @params.appName isnt undefined
      Session.set('currentApp', @params.appName)
      Session.set('currentAppId', Apps.findOne({name: @params.appName})._id)
    else
      Session.set('currentApp', undefined)
      Session.set('currentAppId', undefined)
    Meteor.startup ->
      window.scrollTo(0,0)

Router.map ->
  @route "home",
    path: "/"
  @route "tests",
    path: "/:appName/tests"
    template: "testsList"
    before: ->
      Session.set('statusFilter', 'all')
  @route "settings",
    path: "/:appName/settings"
    template: "settings"
  @route "create",
    path: "/:appName/create"
    template: "createTest"
  @route "edit",
    path: "/:appName/:_id/edit"
    template: "editTest"
    before: ->
      Session.set('currentTest', @params._id)
    data: ->
      Tests.findOne(Session.get('currentTest'))
  @route "show",
    path: "/:appName/:_id/show"
    template: "showTest"
    before: ->
      Session.set('currentTest', @params._id)
    data: ->
      Tests.findOne(Session.get('currentTest'))