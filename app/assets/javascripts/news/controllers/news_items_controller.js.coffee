angular.module("NewsApp")
  .controller "NewsItemsCtrl", [ "$scope", "$window", "NewsItem",  ($scope, $window, NewsItem) ->
    $scope.load = ->
      $scope.items = NewsItem.query()
      $scope.mode = 'add'

    $scope.addItem = (data) ->
      NewsItem.save data, (item) ->
        $scope.items.unshift(new NewsItem(item))
        $scope.item = new NewsItem() # clear the form

    $scope.destroyItem = (item) ->
      if $window.confirm('Are you sure ?')
        NewsItem.delete item, (success) ->
          $scope.items.splice($scope.items.indexOf(item),1)

    $scope.saveItem = (item) ->
      NewsItem.save item
      $scope.mode = 'add'
      $scope.item = new NewsItem() # clear the form

    $scope.editItem = (item) ->
      $scope.item = item
      $scope.mode = 'edit'

    $scope.load()
  ]
