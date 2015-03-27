angular.module('app').directive("pixelCreateForm", ['$rootScope', '$timeout', ($rootScope, $timeout) ->
  restrict: "CA"
  link: (scope, elm, attrs) ->
    initValidation = () ->
      elm.formValidation({
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
              }
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
              }
              stringLength: {
                min: 3
                max: 255
                trim: true
                message: 'Pixel Name must be more then 3 and less than 255 characters'
              }
            }
          }
        }
      }).on('success.form.fv', (e) ->
        $rootScope.pixel = {}
      )

    $timeout(->
      initValidation()
    , 100)

    elm.find(".sharing-options_add").click(->
      $timeout(->
        fields = jQuery(".sharing-option").last().find(".form-control")
        angular.forEach(fields, (field) ->
          elm.data('formValidation').addField(jQuery(field))
        )
      , 100)
    )
    elm.find(".sharing-option_action__trash").click(->
      $timeout(->
        fields = jQuery(".sharing-option").last().find(".form-control")
        angular.forEach(fields, (field) ->
          elm.data('formValidation').removeField(jQuery(field))
        )
      , 100)
    )
]).directive('noEdit', ['$timeout', ($timeout) ->
  restrict: "A"
  scope: {noEdit: "="}
  link: (scope, elm, attrs) ->
    $timeout(->
      width = elm.outerWidth()
      height = elm.outerHeight()
      position = elm.position()
      veil = jQuery('<div class="no-edit_veil"></div>')
      veil.width(width).height(height).css({left: position.left, top: position.top});
      elm.parent().append(veil)
    , 200) if scope.noEdit
])