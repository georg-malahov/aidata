angular.module('app').controller('ModalSegmentsController',
[ '$scope', '$rootScope', '$modalInstance', 'segments', ($scope, $rootScope, $modalInstance, segments) ->
  $rootScope.preloading.page = false
  $scope.modalTitle = "Similar Segments"
  console.info("Segments to show: ", segments)
  $scope.message = "Unknown error occured when requesting segments!"
  if segments.data.status == 'success'
    $scope.segments = segments.data.data
  else
    $scope.message = segments.data.message
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
])