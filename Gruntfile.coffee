module.exports = (grunt) ->

  # configuration
  grunt.initConfig

    # grunt sass
    sass:
      compile:
        options:
          style: 'expanded'
        files: [
          expand: true
          cwd: 'assets/stylesheets/src'
          src: ['**/*.sass']
          dest: 'assets/stylesheets'
          ext: '.css'
        ]

    # grunt coffee
    coffee:
      compile:
        expand: true
        cwd: 'assets/javascripts/src'
        src: ['**/*.coffee']
        dest: 'assets/javascripts'
        ext: '.js'
        options:
          bare: true
          preserve_dirs: true

    # grunt watch (or simply grunt)
    watch:
      html:
        files: ['**/*.php']
      sass:
        files: '<%= sass.compile.files[0].src %>'
        tasks: ['sass']
      coffee:
        files: '<%= coffee.compile.src %>'
        tasks: ['coffee']
      options:
        livereload: true

    # grunt cssmin
    cssmin:
      minify:
        expand: true
        cwd: 'assets/stylesheets'
        src: ['*.css']
        dest: 'assets/stylesheets'
        ext: '.css'

    # grunt uglify
    uglify:
      my_target:
        files:
          'assets/javascripts/gificiency.js': ['assets/javascripts/gificiency.js']

  # Load plugins
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  # tasks
  grunt.registerTask 'default', ['sass', 'coffee', 'watch']
  grunt.registerTask 'min', ['cssmin', 'uglify']
