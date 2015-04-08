angular.module('app').directive("body", [() ->
  restrict: "E"
  link: () ->
    FormValidation.Validator.unique = {
      validate: (validator, $field, options) ->
        value = $field.val()
        return true if !value
        return value is "true"
    }
    FormValidation.Validator.server = {
      validate: (validator, $field, options) ->
        pristine = $field.hasClass("ng-pristine")
        return {
          valid: !pristine
          message: options.message
        }
    }
]).directive("pixelCreateForm", ['$rootScope', '$timeout', '$window', ($rootScope, $timeout, $window) ->
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
        button: {
          selector: '[type="submit"]',
          disabled: ''
        }
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
          },
          "unique[]": {
            excluded: false
            validators: {
              unique: {
                enabled: true
                message: "Different options can't have the same customer Type or ID"
              }
            }
          }
        }
      }).on('success.form.fv', (e) ->
        $rootScope.pixel = {}
      )

    $timeout(->
      initValidation()
      elm.data('formValidation').validate() if angular.isDefined($window.__postedPixel)
      jQuery(".sharing-options_add").click(->
        $timeout(->
          fields = jQuery(".sharing-option").last().find(".form-control")
          angular.forEach(fields, (field) ->
            elm.data('formValidation').addField(jQuery(field))
          )
        , 100)
        jQuery('[type="submit"]').removeClass("disabled").removeAttr("disabled")
      )
    , 100)
    scope.$on("removeOption", () ->
      jQuery('[type="submit"]').removeClass("disabled").removeAttr("disabled")
    )
    $rootScope.$on("revalidateField", (e, name) ->
      elm.formValidation('revalidateField', name);
      elm.data('formValidation').validateField(name);
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