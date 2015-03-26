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
      })

    $timeout(->
      initValidation()
    , 100)

    $rootScope.resetForm = () ->
      elm.data('formValidation').resetForm()
    $rootScope.updateForm = () ->
      elm.data('formValidation').destroy()
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
])