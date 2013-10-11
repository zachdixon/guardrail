
`
  var disqusPublicKey = 'itzhSDIwFDTpMvL5SI5wQOwoIlSoT1grYPDOZOBHf3PZTJpJ8HHbPhCE5OAmXzZg';
  var disqus_shortname = 'guardrail';
  var urlArray = [];
`

Template.testItem.rendered = ->
  `
    (function () {
      var s = document.createElement('script'); s.async = true;
      s.type = 'text/javascript';
      s.src = '//' + disqus_shortname + '.disqus.com/count.js';
      (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
    }());
  `

Template.disqus.rendered = ->
  unless window.DISQUS
    `
      var disqus_identifier = 'test-'+ Session.get('currentTest');
      var disqus_url = 'http://guardrail.meteor.com/'+Session.get('currentTest')+'/show';

      (function() {
       var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
       dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
       (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
       })();
     `
  if window.DISQUS
    DISQUS.reset
      reload: true
      config: ->
        @page.identifier = "test-#{Session.get('currentTest')}"
        @page.url = "http://guardrail.meteor.com/#!#{Session.get('currentTest')}"
        @page.title = "Test #{Session.get('currentTest')}"
  ###
  # We don't want to load Disqus until the first time the template is
  # rendered, since it requires the #disqus_thread div
  # Triggers Deps.autorun (below)
  ###
  # Session.set("loadDisqus", true)

# Deps.autorun(->
#   # Load the Disqus embed.js the first time the `disqus` template is rendered
#   # but never more than once
#   if Session.get("loadDisqus") and not window.DISQUS
#     # Below is the Disqus Universal Code
#     # (in Coffeescript, backticks escape Javascript code)
#     `
#     /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
#     var disqus_shortname = 'guardrail'; // required: replace example with your forum shortname
#     var disqus_identifier = 'newidentifier';
#     var disqus_url = 'http://guardrail.meteor.com/newthread';
#     var disqus_developer = '1';

#     /* * * DON'T EDIT BELOW THIS LINE * * */
#     (function() {
#      var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
#      dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
#      (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
#      })();
#      `
# )