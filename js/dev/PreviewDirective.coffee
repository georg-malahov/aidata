angular.module('app').directive("tablecontrolPreview", ['$rootScope', '$timeout', ($rootScope, $timeout) ->
  restrict: "CA"
  link: (scope, elm, attrs) ->
    elm.popover({
      html: true
      container: 'body'
    #      container: '.content_inner'
    #      viewport: {
    #        selector: '.content_inner'
    #      }
      title: 'Use these pixel code snippets'
      content:  () ->
                pixel_id = ""
                $rootScope.editedPixel and (pixel_id = $rootScope.editedPixel.pixel_id)
                pixel_code_website =  """
                                <script type="text/javascript">
                                  (function (document) {
                                    var iframe = document.createElement('iframe'),
                                      img = document.createElement("img");
                                    iframe.width = "0";
                                    iframe.height = "0";
                                    iframe.frameBorder = "0";
                                    iframe.style.position = "absolute";
                                    iframe.style.left = "-9999px";
                                    iframe.onload = function () {
                                      img.src="http://advombat.ru/0.gif?pid=#{pixel_id}";
                                      iframe.contentDocument.body.appendChild(img);
                                    };
                                    document.body.appendChild(iframe);
                                  })(window.document)
                                </script>
                              """

                pixel_code_advertizing =  """
                                            <img src="http://advombat.ru/0.gif?pid=#{pixel_id}" style="position: absolute; left: -9999px;" />
                                          """
                return """
                          <div style="width:500px;">
                            <h5><u>For websites</u> (should be inserted before closing &lt;/body&gt; tag):</h5>
                            <textarea class="form-control" readonly rows="16" onclick="this.focus();this.select()">#{pixel_code_website}</textarea>
                            <h5><u>For banners</u>:</h5>
                            <textarea class="form-control" readonly rows="2" onclick="this.focus();this.select()">#{pixel_code_advertizing}</textarea>
                          </div>
                        """
#      placement: 'bottom'
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