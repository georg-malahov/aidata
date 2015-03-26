angular.module('app').directive("tablecontrolPreview", ['$rootScope', '$timeout', ($rootScope, $timeout) ->
  restrict: "CA"
  link: (scope, elm, attrs) ->
    elm.popover({
      html: true
      container: 'body'
      content:  () ->
                pixel_id = ""
                $rootScope.editedPixel and (pixel_id = $rootScope.editedPixel.pixel_id)
                pixel_code = "<img src='http://advombat.ru/0.gif?pid=#{pixel_id}' width='0px' height='0px'/>"
                """
                  <textarea class="form-control" readonly onclick="this.focus();this.select()">#{pixel_code}</textarea>
                """
      placement: 'right'
      trigger: 'click'
    })
    onClick = (e) ->
      elm.popover("hide") if !jQuery(e.target).parents(".popover").length
    elm.on("shown.bs.popover", () ->
      jQuery("body").bind("click", onClick)
    )
    elm.on("hidden.bs.popover", () ->
      jQuery("body").unbind("click")
    )
])