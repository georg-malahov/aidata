angular.module('app').controller('ModalController',
[ '$scope', '$rootScope', '$modalInstance', '$window', '$timeout', ($scope, $rootScope, $modalInstance, $window, $timeout) ->
  $scope.customers = $window.__customers
  $scope.currencies = $window.__currencies
  $scope.mode = $modalInstance.mode
  $scope.modalTitle = "Create new pixel"
  $rootScope.pixels = {'edit': {}, 'create': {pixel_id: $rootScope.userName}}
  $rootScope.pixel = $rootScope.pixels[$scope.mode] or {}
  if $scope.mode is 'edit'
    $rootScope.pixel = $rootScope.editedPixel
    $scope.modalTitle = "Edit '#{$rootScope.pixel.pixel_id}' pixel"
  $scope.defaultOption = {new: 1, enabled: true, customer: {type: "google_ddp", id: ""}, cpm: {currency: "USD", cost: ""}}
  $scope.getDefaultOption = () ->
    defaultOption = angular.fromJson(angular.toJson($scope.defaultOption))
    return defaultOption
  $scope.pixelOptions = $rootScope.pixel.options || []
  $scope.ok = ->
    $modalInstance.close();
  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
  $scope.removeOption = (index) ->
    $scope.pixelOptions.splice(index, 1)
    $rootScope.$broadcast("removeOption")
  $scope.$watch("pixelOptions", (newVal, oldVal) ->
    return if angular.equals(newVal, oldVal) and angular.isDefined(oldVal)
    return if newVal.length < 2
    customerOptions = []
    angular.forEach(newVal, (option) ->
      option.customer.unique = !~customerOptions.indexOf([option.customer.type, option.customer.id].join("."))
      customerOptions.push([option.customer.type, option.customer.id].join("."))
    )
    $timeout(->
      $rootScope.$broadcast("revalidateField", "unique[]")
    , 100)
  , true)
])