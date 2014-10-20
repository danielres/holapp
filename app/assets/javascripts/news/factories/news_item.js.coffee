angular.module("NewsApp")
  .factory "NewsItem", [ "$resource", ($resource) ->
    $resource "api/news/items/:id",
      { 'save': {method:'PUT'} },
      { id: "@id" },
  ]
