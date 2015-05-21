angular.module('app', [
  'ui.slider',
  'ui.grid',
  'ui.grid.edit',
  'ui.grid.autoResize',
  'ui.grid.resizeColumns',
  'ui.grid.moveColumns',
  'ui.grid.saveState',
  'ui.grid.selection',
  'ui.grid.exporter',
  'ui.grid.pinning',
  'ui.bootstrap'
]).config([
  '$interpolateProvider', ($interpolateProvider) ->
    $interpolateProvider.startSymbol('[[')
    $interpolateProvider.endSymbol(']]')
]).run([
  '$rootScope',
  ($rootScope) ->
    $rootScope.preloading = {
      page: true
    }
])