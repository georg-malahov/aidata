angular.module('app').directive("tablecontrolLookalike", ['$rootScope', '$compile', '$http', '$timeout', ($rootScope, $compile, $http, $timeout) ->
  restrict: "CA"
  link: (scope, elm, attrs) ->
    scope.lookalikePercent = 0
    scope.createLookalike = (percent, pixel_id) ->
      $http({
        url: "/pixel/#{pixel_id}/lookalike/",
        method: "POST",
        data: jQuery.param({
          percent: percent
        })
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        }
      }).success((response) ->
        console.info("Should reload page! Response: ", response)
        if response.status is "success"
          window.location.reload()
          scope.lookalikeMessage = ""
        else
          scope.lookalikeMessage = response.message or "Sorry, some error occured! Please, try again."
      ).error((response) ->
        console.warn("Should show message! Response: ", response)
        scope.lookalikeMessage = response.message or "Sorry, some error occured! Please, try again."
      )
    elm.popover({
      html: true
      container: 'body'
#      container: '.content_inner'
#      viewport: {
#        selector: '.content_inner'
#      }
      title: () -> return $compile("""<span>Set your look-a-like audience based on \'[[editedPixel.id]]\'!</span>""")($rootScope)
      content:  () ->
                pixel_id = ""
                $rootScope.editedPixel and (pixel_id = $rootScope.editedPixel.id)
                return $compile("""
                  <div class="audience">
                    <p class="alert alert-success">
                      Size range is based on the total audience. Smaller audiences most closely match your source audience.
                      Creating a larger audience increases your potential reach, but reduces the level of similarity to your source.
                    </p>
                    <hr/>
                    <div class="audience-setter">
                      <div class="slider_wrapper">
                        <div class="slider_title slider_title__low">Reach</div>
                        <div class="slider_content">
                          <div ui-slider="{orientation: 'horizontal', range: 'min'}"  min="0" max="100" step="5" ng-model="lookalikePercent"></div>
                        </div>
                        <div class="slider_title slider_title__high">Similarity</div>
                      </div>
                      <hr/>
                      <div class="clearfix">
                        <div class="selected-size"><span class="selected-size-title">Selected value: </span><span class="selected-size-value">[[lookalikePercent]]%</span></div>
                        <div class="selected-btn">
                          <button class="btn btn-block btn-primary" ng-click="createLookalike(lookalikePercent, '#{pixel_id}')">Create new look-a-like audience</button>
                        </div>
                      </div>
                      <div class="lookalike-error" ng-show="lookalikeMessage">
                        <p class="alert alert-warning" ng-bind="lookalikeMessage"></p>
                      </div>
                    </div>
                  </div>
                """)(scope)
      placement: 'bottom'
      trigger: 'click'
    })
    onClick = (e) ->
      elm.popover("hide") if !jQuery(e.target).parents(".popover").length
    elm.on("shown.bs.popover", () ->
      $timeout(-> scope.$apply(-> scope.lookalikeMessage = "" ))
      jQuery("body").bind("click", onClick)
    )
    elm.on("hidden.bs.popover", () ->
      jQuery("body").unbind("click")
    )
])