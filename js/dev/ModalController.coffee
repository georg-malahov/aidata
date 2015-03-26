angular.module('app').controller('ModalController',
[ '$scope', '$rootScope', '$modalInstance', '$window', ($scope, $rootScope, $modalInstance, $window) ->
  $scope.customers = $window.__customers
  $scope.currencies = $window.__currencies
  $scope.selectedCustomer = {
    "id": "1",
    "name": "Google DDP"
  }
  $scope.selectedCurrency = {
    "name": "United States Dollar"
    "id": "USD"
  }
  $scope.options = [{}]
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
])