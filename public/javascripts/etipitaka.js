angular.module('etipitaka', ['ngResource']).
  factory('Page', function($resource) {
    var Page = $resource(
      'http://etipitaka.com/rest/:lang/?limit=1&filter_volume=:volume&filter_page=:page');        
    return Page;
  });