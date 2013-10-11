# Meteor.startup ->
#   unless Tests.find().count() > 0

#     categories = ["login", "overview", "invoices", "settings", "account", "comments"]
#     _.each categories, (category) ->
#       c = Categories.insert
#         app: "socialcompass"
#         name: category
#       for i in [1..20]
#         t = Meteor.call 'getServerTime'
#         Tests.insert
#           app: "socialcompass"
#           category: c
#           description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed risus nec dolor congue pharetra quis quis magna. Praesent bibendum metus eu commodo pretium."
#           status: "untested"
#           title: "Lorem Ipsum"
#           created_at: t