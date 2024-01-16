// Karma configuration file, see link for more information
// https://karma-runner.github.io/1.0/config/configuration-file.html

module.exports = function (config) {
  config.set({
    basePath: '',
    frameworks: ['jasmine', '@angular-devkit/build-angular'],
    plugins: [
      require('karma-jasmine'),
      require('karma-firefox-launcher'),
      require('karma-jasmine-html-reporter'),
      require('karma-coverage'),
      require('@angular-devkit/build-angular/plugins/karma')
    ],
    client: {
      jasmine: {
        // you can add configuration options for Jasmine here
        // the possible options are listed at https://jasmine.github.io/api/edge/Configuration.html
        // for example, you can disable the random execution with `random: false`
        // or set a specific seed with `seed: 4321`
      },
      clearContext: false // leave Jasmine Spec Runner output visible in browser
    },
    jasmineHtmlReporter: {
      suppressAll: true // removes the duplicated traces
    },
    coverageReporter: {
      dir: require('path').join(__dirname, './coverage/landing-page-interface'),
      subdir: '.',
      reporters: [
        { type: 'html' },
        { type: 'text-summary' }
      ]
    },
    reporters: ['progress', 'kjhtml'],

    // Specify Firefox headless.
    browsers: ['FirefoxHeadless'],
    customLaunchers: {
      FirefoxHeadless: {
        base: 'Firefox',

        // Path to your 'test' Firefox profile.
        // Can create/edit profile by opening Firefox, and then 
        // 'about:profiles' in the search bar.
        profile: '/home/marco/snap/firefox/common/.mozilla/firefox/pexkeons.test',

        // Path to Firefox executable.
        firefox_binary: '/snap/bin/firefox',
        flags: '-headless'
        // Optionally, specify the path to the Firefox executable
        // firefox_binary: '<path-to-firefox-executable>'
      }
    },
    // Run tests once then exit.
    singleRun: true,
    // Restart the browser if any file included in the Karma configuration changes.
    restartOnFileChange: true
  });
};
