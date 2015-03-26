angular.module('app').directive("tablecontrolPreview", ['$rootScope', '$timeout', ($rootScope, $timeout) ->
  restrict: "CA"
  link: (scope, elm, attrs) ->
    elm.popover({
      html: true
      container: 'body'
      content:  () ->
                pixel_id = ""
                $rootScope.editedPixel and (pixel_id = $rootScope.editedPixel.pixel_id)
                pixel_code =  """
                                <script type="text/javascript">
                                  (function (document) {
                                    var iframe = document.createElement('iframe'),
                                      img = document.createElement("img");
                                    iframe.width = "0";
                                    iframe.height = "0";
                                    iframe.onload = function () {
                                      img.src="http://advombat.ru/0.gif?pid=#{pixel_id}";
                                      iframe.contentDocument.body.appendChild(img);
                                    };
                                    document.body.appendChild(iframe);
                                  })(window.document)
                                </script>
                              """
                return """
                  <textarea class="form-control" readonly rows="13" onclick="this.focus();this.select()">#{pixel_code}</textarea>
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