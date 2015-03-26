angular.module('app').controller('MainController',
[ '$scope', '$rootScope', '$modal', '$window', ( $scope, $rootScope, $modal, $window) ->
    $rootScope.preloading.page = false
    $scope.openModal = (size) ->
      modalInstance = $modal.open({
        templateUrl: 'modal.html'
        controller: 'ModalController'
#        backdrop: 'static'
#        keyboard: false
        size: size
        resolve: {
          items: ->
            return $scope.items
        }
      })
      modalInstance.result.then((selectedItem) ->
        $scope.selected = selectedItem;
      , () ->
        console.info('Modal dismissed at: ' + new Date());
      )
    $scope.openModal('lg') if !$window.__pixels.length
])