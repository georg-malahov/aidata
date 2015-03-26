angular.module('app').controller('ModalController',
[ '$scope', '$rootScope', '$modalInstance', '$window', ($scope, $rootScope, $modalInstance, $window) ->
  $scope.customers = $window.__customers
  $scope.currencies = $window.__currencies
  $scope.pixel = $rootScope.editedPixel || {}
  $scope.defaultOption = {new: 1, customer: {type: "1", id: ""}, cpm: {currency: "USD", cost: ""}}
  $scope.getDefaultOption = () ->
    defaultOption = angular.fromJson(angular.toJson($scope.defaultOption))
    return defaultOption
  $scope.pixelOptions = $scope.pixel.options || [$scope.getDefaultOption()]
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
])