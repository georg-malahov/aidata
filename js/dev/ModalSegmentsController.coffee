angular.module('app').controller('ModalSegmentsController',
[ '$scope', '$rootScope', '$modalInstance', 'segments', ($scope, $rootScope, $modalInstance, segments) ->
  $rootScope.preloading.page = false
  $scope.modalTitle = "Similar Segments"
  console.info("Segments to show: ", segments)
  message = "Unknown error occured when requesting segments!"
  if segments.status == 'success'
    $scope.segments = segments.data
  else
    $scope.message = segments.message || message
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
])