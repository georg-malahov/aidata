angular.module('app').controller('ModalSegmentsController',
[ '$scope', '$rootScope', '$modalInstance', 'segments', ($scope, $rootScope, $modalInstance, segments) ->
  $rootScope.preloading.page = false
  $scope.modalTitle = "Recommended Segments for '#{$rootScope.editedPixel.pixel_id}' pixel"
  console.info("Segments to show: ", segments)
  message = "Unknown error occured when requesting segments!"
  if segments.status == 'success'
    $scope.segments = segments.data
    $scope.message = "No similar segments found" if angular.isArray(segments.data) and !segments.data.length
  else
    $scope.message = segments.message || message
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
])