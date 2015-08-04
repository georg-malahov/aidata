angular.module('app').factory('ColumnsService', ->
  [
    {
      field: 'pixel_id'
      displayName: 'Pixel ID'
      cellClass: 'to-left'
      headerCellClass: "to-left"
      minWidth: 100
      width: "*"
    }
    {
      field: 'status'
      displayName: 'Status'
      cellClass: 'to-left'
      headerCellClass: "to-left"
      minWidth: 100
      width: "*"
    }
    {
      field: 'type'
      displayName: 'Type'
      cellClass: 'to-left'
      headerCellClass: "to-left"
      minWidth: 100
      width: "*"
    }
    {
      field: 'name'
      displayName: 'Name'
      cellClass: 'to-left'
      headerCellClass: "to-left"
      minWidth: 100
      width: "*"
    }
    {
      field: 'total_impressions'
      displayName: 'Impressions'
      cellClass: 'to-right'
      headerCellClass: "center"
      cellFilter: 'number',
      minWidth: 100
    }
    {
      field: 'total_cost'
      displayName: 'Cost'
      cellClass: 'to-right'
      headerCellClass: "center"
      cellFilter: 'number',
      minWidth: 100
    }
    {
      field: 'size'
      displayName: 'Size'
      cellClass: 'to-right'
      headerCellClass: "center"
      cellFilter: 'number',
      minWidth: 100
    }
    {
      field: 'updated'
      displayName: 'Updated'
      cellClass: 'center'
      headerCellClass: "center"
      cellFilter: 'date : "yyyy-MM-dd HH:mm"',
      minWidth: 100
    }
    {
      field: 'created'
      displayName: 'Created'
      cellClass: 'center'
      headerCellClass: "center"
      cellFilter: 'date : "yyyy-MM-dd HH:mm"',
      minWidth: 100
    }
  ]
)