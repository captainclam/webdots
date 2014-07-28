# Boilerplate

Base npm and grunt conf for simple dev projects.


## TODO / Consider
- https://github.com/vojtajina/grunt-bump
- https://github.com/gunta/grunt-manifest

```
manifest:
  generate: 
    options: 
      basePath: "www",
      network: ["*"],
      timestamp: true
    src: [
      '*.html'
      'images/*.gif'
      'images/*.png'
      'css/*.css'
      'js/*.js'
    ]
    dest: "www/manifest.appcache"
grunt.loadNpmTasks 'grunt-manifest'
```
