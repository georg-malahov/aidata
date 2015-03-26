angular.module('app').controller('TableController',
[ '$scope', '$rootScope', '$filter', '$timeout', '$interpolate', '$window', 'ColumnsService',
  ( $scope, $rootScope, $filter, $timeout, $interpolate, $window, ColumnsService) ->
    $scope.gridScope = {}
    $scope.startSym = $interpolate.startSymbol()
    $scope.endSym = $interpolate.endSymbol()
    console.log("$window.__pixels: ", $window.__pixels)
    console.log("ColumnsService: ", ColumnsService)
    $scope.preloading.page = false
    $scope.gridOptions =
      saveScroll: false
      saveFilter: false
      saveFocus: false
      saveRowIdentity: false
      saveSelection: false
      enableGridMenu: true
      showGridFooter: false
      showColumnFooter: false
      data: $window.__pixels
      columnDefs: ColumnsService,
      onRegisterApi: (gridApi) ->
        $scope.gridApi = gridApi
        count = $window.__pixels.length
        if count <= 50
          angular.element(document.getElementsByClassName('tablegrid_grid')[0]).css('height', count * 30 + 45 + 'px')
        else
          angular.element(document.getElementsByClassName('tablegrid_grid')[0]).css('height', 50 * 30 + 45 + 'px')
        gridApi.selection.on.rowSelectionChanged($scope, (row) ->
          selectedRows = gridApi.selection.getSelectedGridRows()
          console.log("selectedRows: ", selectedRows)
        )
        gridApi.selection.on.rowSelectionChangedBatch($scope, (rows) ->
          selectedRows = gridApi.selection.getSelectedGridRows()
          console.log("selectedRows: ", selectedRows)
        )
])