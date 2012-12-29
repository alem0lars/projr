requirejs.config({
  // By default load any module IDs from js/lib
  baseUrl: 'scripts/lib',
  // except, if the module ID starts with "app", load it from the "js/app" dir.
  // "paths" config is relative to the baseUrl, and never includes a ".js"
  // extension since the paths config could be for a directory.
  paths: {
    app: '../app'
  }
});

// Start the main app logic
requirejs(['jquery'],
  function   ($) {
    // Required modules are all loaded and can be used here now
  }
);
