requirejs.config({
  // By default load any module IDs from js/lib
  baseUrl: 'scripts/lib',
  // except, if the module ID starts with "app", load it from the "js/app" dir.
  // "paths" config is relative to the baseUrl, and never includes a ".js"
  // extension since the paths config could be for a directory.
  paths: {
    app: '../app'
  },

  shim: {
    'jquery': {
      deps: [],
      exports: 'jquery',
      init: function (jquery) { /* No function init at the moment */ }
    },
    'videojs': {
      deps: [],
      exports: 'videojs',
      init: function (videojs) { /* No function init at the moment */ }
    },
    'bootstrap': {
      deps: ['jquery'],
      exports: 'bootstrap',
      init: function (bootstrap) { /* No function init at the moment */ }
    },
    'nivoslider': {
      deps: ['jquery'],
      exports: 'nivoslider',
      init: function (nivoslider) { /* No function init at the moment */ }
    },
    'twitter': {
      deps: [],
      exports: 'twitter',
      init: function (twitter) { /* No function init at the moment */ }
    }
  }
});

requirejs([
  'domReady',
  'jquery',
  'bootstrap',
  'videojs',
  'nivoslider',
  'twitter',

  'app/header',
  'app/footer',
  'app/navigation',

  'app/index'
]);
