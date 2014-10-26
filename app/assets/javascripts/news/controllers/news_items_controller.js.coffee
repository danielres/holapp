angular.module("NewsApp")
  .controller "NewsItemsCtrl", [ "$scope", "$window", "NewsItem",  ($scope, $window, NewsItem) ->
    $scope.load = ->
      $scope.news_items = NewsItem.query()
      $scope.mode = 'add'

    $scope.addItem = (data) ->
      NewsItem.save data, (news_item) ->
        $scope.news_items.unshift(new NewsItem(news_item))
        $scope.news_item = new NewsItem() # clear the form

    $scope.destroyItem = (news_item) ->
      if $window.confirm('Are you sure ?')
        NewsItem.delete news_item, (success) ->
          $scope.news_items.splice($scope.news_items.indexOf(news_item),1)

    $scope.saveItem = (news_item) ->
      NewsItem.save news_item
      $scope.mode = 'add'
      $scope.news_item = new NewsItem() # clear the form

    $scope.editItem = (news_item) ->
      $scope.news_item = news_item
      $scope.mode = 'edit'

    $scope.load()
  ]
