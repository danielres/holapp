angular.module("NewsApp")
  .factory "NewsItem", [ "$resource", ($resource) ->
    $resource "/api/news/items/:id", {},
    { update: { method: "PUT" } }
  ]


