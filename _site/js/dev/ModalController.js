// Generated by CoffeeScript 1.8.0
angular.module('app').controller('ModalController', [
  '$scope', '$rootScope', '$modalInstance', '$window', function($scope, $rootScope, $modalInstance, $window) {
    $scope.customers = $window.__customers;
    $scope.currencies = $window.__currencies;
    $scope.selectedCustomer = {
      "id": "1",
      "name": "Google DDP"
    };
    $scope.selectedCurrency = {
      "name": "United States Dollar",
      "id": "USD"
    };
    $scope.options = [{}];
    $scope.ok = function() {
      return $modalInstance.close();
    };
    return $scope.cancel = function() {
      return $modalInstance.dismiss('cancel');
    };
  }
]);