angular.module('app').controller('MainController',
[ '$scope', '$rootScope', '$modal', '$window', ( $scope, $rootScope, $modal, $window) ->
    $rootScope.preloading.page = false
    $scope.openModal = (size, mode) ->
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
      modalInstance.mode = mode
      modalInstance.result.then((selectedItem) ->
        $scope.selected = selectedItem;
      , () ->
        console.info('Modal dismissed at  : ' + new Date());
      )
    if $window.__user
      $rootScope.userName = $window.__user.company + ($window.__pixels.length + 1)
    $scope.openModal('lg') if !$window.__pixels.length
    if angular.isDefined($window.__postedPixel)
      $rootScope.editedPixel = $window.__postedPixel
      $scope.openModal('lg', 'edit')
])