if [ "$1" != "" ]; then
	project_template=$1
else
        project_template=project
fi

project=$project_template
counter=0

while [ -d $project  ]; do
        let counter=counter+1
        project=$project_template$counter
done

mkdir $project

#mkdir project

cd $project
mkdir css
echo 'h1 {
    color: red;
}' > css/main.css
mkdir js
echo 'const foo = require('"'"'./foo.js'"'"');
const bar = require('"'"'./bar.js'"'"');

console.log(`${foo()} and ${bar()}`);
' > js/main.js
echo 'function foo() {
  return '"'"'foo'"'"';
}

module.exports = foo;' > js/foo.js
echo 'function bar() {
  return '"'"'bar'"'"';
}

module.exports = bar;' > js/bar.js
echo '<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Title</title>
    <link rel="stylesheet" href="css/main.css">
</head>
<body>
    <h1>Hello, World!!</h1>
    <script src="build/bundle.js"></script>
</body>
</html>' > index.html
echo 'module.exports = function (grunt) {
  // Project configuration.
  grunt.initConfig({
    pkg: grunt.file.readJSON('"'"'package.json'"'"'),
    watch: {
      scripts: {
        files: ['"'"'js/*.js'"'"'],
        tasks: ['"'"'eslint'"'"', '"'"'browserify'"'"'],
        options: {
          spawn: false,
        },
      },
    },
    eslint: {
      target: ['"'"'js/*.js'"'"'],
    },
    browserify: {
      dist: {
        files: {
          '"'"'build/bundle.js'"'"': ['"'"'js/*.js'"'"'],
        },
      },
    },
    browserSync: {
      bsFiles: {
        src: ['"'"'*.html'"'"', '"'"'css/*.css'"'"', '"'"'build/*.js'"'"'],
      },
      options: {
        server: {
          baseDir: '"'"'./'"'"',
        },
      },
    },
  });

  // Load the plugin that provides the "uglify" task.
  grunt.loadNpmTasks('"'"'grunt-contrib-watch'"'"');
  grunt.loadNpmTasks('"'"'grunt-eslint'"'"');
  grunt.loadNpmTasks('"'"'grunt-browserify'"'"');
  grunt.loadNpmTasks('"'"'grunt-browser-sync'"'"');

  // Default task(s).
  grunt.registerTask('"'"'default'"'"', ['"'"'eslint'"'"', '"'"'browserify'"'"', '"'"'watch'"'"']);
  grunt.registerTask('"'"'bsync'"'"', ['"'"'browserSync'"'"']);
};' > Gruntfile.js
echo 'node_modules' > .gitignore
#npm init -y
echo '{
  "name": "'${project}'",
  "version": "0.0.1",
  "description": "",
  "main": "main.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "Jason Figueroa",
  "license": "MIT"
}
' > package.json
npm install grunt --save-dev
npm install git://github.com/gruntjs/grunt-contrib-uglify.git#harmony --save-dev
npm install grunt-contrib-watch --save-dev
npm install grunt-eslint --save-dev
npm install grunt-browserify --save-dev
npm install grunt-browser-sync --save-dev
node_modules/.bin/eslint --init
echo 'module.exports = {
  "extends": "airbnb-base",
  "env": {
    "browser": true
  },
  "rules": {
    "no-plusplus": 0,
    // TODO if windows uncomment the following else delete
    // "linebreak-style": ["error", "windows"]
  },
};' > .eslintrc.js
