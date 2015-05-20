angular.module('app').controller('MainController',
[ '$scope', '$rootScope', '$modal', '$window', '$http', '$q', ( $scope, $rootScope, $modal, $window, $http, $q) ->
    $rootScope.preloading.page = false
    $scope.openModal = (size, mode) ->
      switch mode
        when 'create', 'edit'
          modalInstance = $modal.open({
            templateUrl: 'modal.html'
            controller: 'ModalController'
    #        backdrop: 'static'
    #        keyboard: false
            size: size
          })
          modalInstance.mode = mode
        when 'segments'
          $rootScope.preloading.page = true
          deferred = $q.defer()
          $http.get("pixel/#{$rootScope.editedPixel.pixel_id}/affinity.json").success((response) ->
            deferred.resolve(response)
          ).error((response) -> deferred.resolve({status: 'error', data: response}))
          modalInstance = $modal.open({
            templateUrl: 'modal__segments.html'
            controller: 'ModalSegmentsController'
          #        backdrop: 'static'
          #        keyboard: false
            size: size
            resolve: {
              segments: -> deferred.promise
            }
          })
      modalInstance.result.then((result) ->
        $scope.result = result;
      , () ->
        console.info('Modal dismissed at  : ' + new Date());
        if angular.isDefined($window.__postedPixel)
          delete $window.__postedPixel
          $rootScope.editedPixel = false
      )
    if $window.__user
      $rootScope.userName = $window.__user.company + ($window.__pixels.length + 1)
    $scope.openModal('lg') if !$window.__pixels.length
    if angular.isDefined($window.__postedPixel)
      $rootScope.editedPixel = $window.__postedPixel
      $scope.openModal('lg', 'edit')
])