angular.module('app').controller('TableController',
[ '$scope', '$rootScope', '$filter', '$timeout', '$interpolate', '$window', 'ColumnsService',
  ( $scope, $rootScope, $filter, $timeout, $interpolate, $window, ColumnsService) ->
    $scope.gridScope = {}
    $scope.startSym = $interpolate.startSymbol()
    $scope.endSym = $interpolate.endSymbol()
    editPixelTooltip = "Select at least one pixel from the table."
    date = new Date()
    $scope.editPixelTooltip = editPixelTooltip
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
      multiSelect: false
      exporterCsvFilename: "pixels_(#{date.toISOString()}).csv"
      exporterFieldCallback: (grid, row, col, value) ->
        if col.name is 'updated' or col.name is 'created'
         value = $filter('date')(value, "yyyy-MM-dd HH:mm")
        return value;
      data: $window.__pixels
      columnDefs: ColumnsService,
      onRegisterApi: (gridApi) ->
        $scope.gridApi = gridApi
        count = $window.__pixels.length
        if count <= 50
          angular.element(document.getElementsByClassName('tablegrid_grid')[0]).css('height', count * 30 + 45 + 'px')
        else
          angular.element(document.getElementsByClassName('tablegrid_grid')[0]).css('height', 50 * 30 + 45 + 'px')
        $timeout(() ->
          angular.element(document.getElementsByClassName('ui-grid-canvas')[1]).css('height', 'auto')
        , 100)
        gridApi.selection.on.rowSelectionChanged($scope, (row) ->
          selectedRows = gridApi.selection.getSelectedGridRows()
          if selectedRows.length
            $rootScope.editedPixel = selectedRows[0].entity
            $scope.editPixelTooltip = ""
          else
            $rootScope.editedPixel = false
            $scope.editPixelTooltip = editPixelTooltip
          console.log("selectedRows: ", $rootScope.editedPixel)
        )
])