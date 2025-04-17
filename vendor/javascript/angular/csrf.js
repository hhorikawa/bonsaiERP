myApp.config(['$httpProvider', function($httpProvider) {
  var authToken = $('meta[name="csrf-token"]').attr("content");
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken;
}]);