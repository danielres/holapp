angular.module("NewsApp")
  .factory "NewsItem", [ "$resource", ($resource) ->
    $resource "/news/items/:id", { 'save': {method:'PUT'} },
      { id: "@id" },
      { update: { method: "PUT" }}
  ]
