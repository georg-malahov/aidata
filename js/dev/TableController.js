// Generated by CoffeeScript 1.8.0
angular.module('app').controller('TableController', [
  '$scope', '$rootScope', '$filter', '$timeout', '$interpolate', '$window', 'ColumnsService', function($scope, $rootScope, $filter, $timeout, $interpolate, $window, ColumnsService) {
    var date, editPixelTooltip;
    $scope.gridScope = {};
    $scope.startSym = $interpolate.startSymbol();
    $scope.endSym = $interpolate.endSymbol();
    editPixelTooltip = "Select at least one pixel from the table.";
    date = new Date();
    $scope.editPixelTooltip = editPixelTooltip;
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
      multiSelect: false,
      exporterCsvFilename: "pixels_(" + (date.toISOString()) + ").csv",
      exporterFieldCallback: function(grid, row, col, value) {
        if (col.name === 'updated' || col.name === 'created') {
          value = $filter('date')(value, "yyyy-MM-dd HH:mm");
        }
        return value;
      },
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
        $timeout(function() {
          return angular.element(document.getElementsByClassName('ui-grid-canvas')[1]).css('height', 'auto');
        }, 100);
        return gridApi.selection.on.rowSelectionChanged($scope, function(row) {
          var selectedRows;
          selectedRows = gridApi.selection.getSelectedGridRows();
          if (selectedRows.length) {
            $rootScope.editedPixel = selectedRows[0].entity;
            $scope.editPixelTooltip = "";
          } else {
            $rootScope.editedPixel = false;
            $scope.editPixelTooltip = editPixelTooltip;
          }
          return console.log("selectedRows: ", $rootScope.editedPixel);
        });
      }
    };
  }
]);
