/* createApp.js begin */
// Generated by CoffeeScript 1.8.0
angular.module('app', ['ui.grid', 'ui.grid.edit', 'ui.grid.autoResize', 'ui.grid.resizeColumns', 'ui.grid.moveColumns', 'ui.grid.saveState', 'ui.grid.selection', 'ui.grid.exporter', 'ui.grid.pinning', 'ui.bootstrap']).config([
  '$interpolateProvider', function($interpolateProvider) {
    $interpolateProvider.startSymbol('[[');
    return $interpolateProvider.endSymbol(']]');
  }
]).run([
  '$rootScope', function($rootScope) {
    return $rootScope.preloading = {
      page: true
    };
  }
]);

/* createApp.js end */

/* MainController.js begin */
// Generated by CoffeeScript 1.8.0
angular.module('app').controller('MainController', [
  '$scope', '$rootScope', '$modal', '$window', function($scope, $rootScope, $modal, $window) {
    $rootScope.preloading.page = false;
    $scope.openModal = function(size) {
      var modalInstance;
      modalInstance = $modal.open({
        templateUrl: 'modal.html',
        controller: 'ModalController',
        size: size,
        resolve: {
          items: function() {
            return $scope.items;
          }
        }
      });
      return modalInstance.result.then(function(selectedItem) {
        return $scope.selected = selectedItem;
      }, function() {
        return console.info('Modal dismissed at: ' + new Date());
      });
    };
    if (!$window.__pixels.length) {
      return $scope.openModal('lg');
    }
  }
]);

/* MainController.js end */

/* ModalController.js begin */
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

/* ModalController.js end */

/* TableController.js begin */
// Generated by CoffeeScript 1.8.0
angular.module('app').controller('TableController', [
  '$scope', '$rootScope', '$filter', '$timeout', '$interpolate', '$window', 'ColumnsService', function($scope, $rootScope, $filter, $timeout, $interpolate, $window, ColumnsService) {
    $scope.gridScope = {};
    $scope.startSym = $interpolate.startSymbol();
    $scope.endSym = $interpolate.endSymbol();
    console.log("$window.__pixels: ", $window.__pixels);
    console.log("ColumnsService: ", ColumnsService);
    $scope.preloading.page = false;
    return $scope.gridOptions = {
      saveScroll: false,
      saveFilter: false,
      saveFocus: false,
      saveRowIdentity: false,
      saveSelection: false,
      enableGridMenu: true,
      showGridFooter: false,
      showColumnFooter: false,
      data: $window.__pixels,
      columnDefs: ColumnsService,
      onRegisterApi: function(gridApi) {
        var count;
        $scope.gridApi = gridApi;
        count = $window.__pixels.length;
        if (count <= 50) {
          angular.element(document.getElementsByClassName('tablegrid_grid')[0]).css('height', count * 30 + 45 + 'px');
        } else {
          angular.element(document.getElementsByClassName('tablegrid_grid')[0]).css('height', 50 * 30 + 45 + 'px');
        }
        gridApi.selection.on.rowSelectionChanged($scope, function(row) {
          var selectedRows;
          selectedRows = gridApi.selection.getSelectedGridRows();
          return console.log("selectedRows: ", selectedRows);
        });
        return gridApi.selection.on.rowSelectionChangedBatch($scope, function(rows) {
          var selectedRows;
          selectedRows = gridApi.selection.getSelectedGridRows();
          return console.log("selectedRows: ", selectedRows);
        });
      }
    };
  }
]);

/* TableController.js end */

/* FormDirective.js begin */
// Generated by CoffeeScript 1.8.0
angular.module('app').directive("pixelCreateForm", [
  '$rootScope', '$timeout', function($rootScope, $timeout) {
    return {
      restrict: "CA",
      link: function(scope, elm, attrs) {
        var initValidation;
        initValidation = function() {
          return elm.formValidation({
            framework: 'bootstrap',
            icon: {
              valid: 'glyphicon glyphicon-ok',
              invalid: 'glyphicon glyphicon-remove',
              validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
              id: {
                validators: {
                  notEmpty: {
                    message: 'Pixel ID is required'
                  },
                  regexp: {
                    regexp: /^[\d|\w|\-|\_]*$/i,
                    message: 'Pixel ID can consist of alphabetical and digital characters as well ad "-" and "_" symbols only'
                  }
                }
              },
              name: {
                validators: {
                  notEmpty: {
                    message: 'Pixel Name is required'
                  },
                  stringLength: {
                    min: 3,
                    max: 255,
                    trim: true,
                    message: 'Pixel Name must be more then 3 and less than 255 characters'
                  }
                }
              }
            }
          });
        };
        $timeout(function() {
          return initValidation();
        }, 100);
        $rootScope.resetForm = function() {
          return elm.data('formValidation').resetForm();
        };
        $rootScope.updateForm = function() {
          elm.data('formValidation').destroy();
          return initValidation();
        };
        return elm.find(".sharing-options_add, .trash").click(function() {
          return $timeout(function() {
            $rootScope.updateForm();
            if (jQuery(this).hasClass(".trash")) {
              return scope.options.splice($index, 1);
            }
          }, 100);
        });
      }
    };
  }
]);

/* FormDirective.js end */

/* СolumnsService.js begin */
// Generated by CoffeeScript 1.8.0
angular.module('app').factory('ColumnsService', function() {
  return [
    {
      field: 'pixel_id',
      displayName: 'Pixel ID',
      cellClass: 'to-left',
      headerCellClass: "to-left",
      minWidth: 100,
      width: "*"
    }, {
      field: 'status',
      displayName: 'Status',
      cellClass: 'to-left',
      headerCellClass: "to-left",
      minWidth: 100,
      width: "*"
    }, {
      field: 'name',
      displayName: 'Name',
      cellClass: 'to-left',
      headerCellClass: "to-left",
      minWidth: 100,
      width: "*"
    }, {
      field: 'size',
      displayName: 'Size',
      cellClass: 'to-right',
      headerCellClass: "center",
      cellFilter: 'number',
      minWidth: 100
    }, {
      field: 'created',
      displayName: 'Created',
      cellClass: 'center',
      headerCellClass: "center",
      cellFilter: 'date : "yyyy-MM-dd HH:mm"',
      minWidth: 100
    }
  ];
});

/* СolumnsService.js end */

/* bootstrapApp.js begin */
// Generated by CoffeeScript 1.8.0
angular.bootstrap(document, ['app']);

/* bootstrapApp.js end */
