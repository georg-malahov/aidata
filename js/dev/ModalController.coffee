angular.module('app').controller('ModalController',
[ '$scope', '$rootScope', '$modalInstance', '$window', ($scope, $rootScope, $modalInstance, $window) ->
  $scope.customers = $window.__customers
  $scope.currencies = $window.__currencies
  $scope.mode = $modalInstance.mode
  $rootScope.pixel = $rootScope.pixel or {}
  if $scope.mode is 'edit'
    $rootScope.pixel = $rootScope.editedPixel
  $scope.defaultOption = {new: 1, enabled: true, customer: {type: "1", id: ""}, cpm: {currency: "USD", cost: ""}}
  $scope.getDefaultOption = () ->
    defaultOption = angular.fromJson(angular.toJson($scope.defaultOption))
    return defaultOption
  $scope.pixelOptions = $rootScope.pixel.options || [$scope.getDefaultOption(), $scope.getDefaultOption()]
  $scope.customer_type = $scope.pixelOptions[0].customer.type or "1"
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
])