app.directive('rating', ['User', function (User) {
  return {
    scope: {
      user: "="
    },
    restrict: 'E',
    templateUrl: 'rating.html',
    replace: true,
    link: function($scope, iElm, iAttrs, controller) {
      $scope.rate = function (positive) {
        User.rate({id: $scope.user.id, positive: positive}, function (res) {
          $scope.user.rating = res.rating;
        })
      }
    }
  };
}]);
