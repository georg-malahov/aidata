// Generated by CoffeeScript 1.8.0
angular.module('app').controller('MainController', [
  '$scope', '$rootScope', '$modal', '$window', function($scope, $rootScope, $modal, $window) {
    $rootScope.preloading.page = false;
    $scope.openModal = function(size, mode) {
      var modalInstance;
      modalInstance = $modal.open({
        templateUrl: 'modal.html',
        controller: 'ModalController',
        size: size,
        resolve: {
          items: function() {
            return $scope.items;
          }
        }
      });
      modalInstance.mode = mode;
      return modalInstance.result.then(function(selectedItem) {
        return $scope.selected = selectedItem;
      }, function() {
        return console.info('Modal dismissed at  : ' + new Date());
      });
    };
    if ($window.__user) {
      $rootScope.userName = $window.__user.company + ($window.__pixels.length + 1);
    }
    if (!$window.__pixels.length) {
      return $scope.openModal('lg');
    }
  }
]);
