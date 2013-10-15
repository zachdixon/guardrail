
`
  var disqusPublicKey = 'itzhSDIwFDTpMvL5SI5wQOwoIlSoT1grYPDOZOBHf3PZTJpJ8HHbPhCE5OAmXzZg';
  var disqus_shortname = 'guardrail';
`

Template.testItems.rendered = ->
  # `
  #   (function () {
  #     var s = document.createElement('script'); s.async = true;
  #     s.type = 'text/javascript';
  #     s.src = '//' + window.disqus_shortname + '.disqus.com/count.js';
  #     (document.getElementsByTagName('HEAD')[0] || document.getElementsByTagName('BODY')[0]).appendChild(s);
  #   }());
  # `

Template.disqus.rendered = ->
  unless window.DISQUS
    `
      var disqus_identifier = 'test-'+ Session.get('currentTest');
      var disqus_url = 'http://guardrail.meteor.com/'+Session.get('currentTest')+'/show';

      (function() {
       var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
       dsq.src = '//' + window.disqus_shortname + '.disqus.com/embed.js';
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
  