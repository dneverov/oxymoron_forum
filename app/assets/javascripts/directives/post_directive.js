app.directive('post', ['Post', function(Post){
  return {
    scope: {
      post: "="
    },
    restrict: 'E',
    templateUrl: 'post.html',
    replace: true,
    link: function($scope, iElm, iAttrs, controller) {
      $scope.gon = gon;
      $scope.destroy = function () {
        if (confirm("Вы уверены?"))
          Post.destroy({id: $scope.post.id})
      }
    }
  };
}]);
