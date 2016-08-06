module.exports = function (grunt) {

	grunt.loadNpmTasks('grunt-contrib-connect');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-contrib-clean');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-open');
	grunt.loadNpmTasks('grunt-haxe');

	grunt.initConfig({

		connect:
		{
			server:
			{
				options:
				{
					port: 8080,
					base: './bin',
					livereload: true,
					debug: true,
					hostname: "0.0.0.0",
					open: 'http://127.0.0.1:8080'
				}
			}
		},

		watch:
		{
			debug:
			{
				files: ['src/**/*.hx', 'build_debug.hxml', 'html/index_dev.html', 'assets/**/*.*'],
				tasks: ['haxe:debug', 'copy:assets', 'copy:html_dev'],
				options:
				{
					livereload: true,
					livereloadOnError: false
				}
			},
			release:
			{
				files: ['src/**/*.hx', 'build_release.hxml', 'html/index_release.html', 'assets/**/*.*'],
				tasks: ['haxe:release', 'copy:assets', 'copy:html_release'],
				options:
				{
					livereload: true,
					livereloadOnError: false
				}
			},
			haxe:
			{
				files: ['src/**/*.hx', 'html/build_debug.hxml'],
				tasks: ['haxe:debug'],
				options:
				{
					livereload: true
				}
			}
		},

		haxe:
		{
			debug:
			{
				src: ['src/**/*.hx', 'build_debug.hxml'],
				hxml: 'build_debug.hxml'
			},
			release:
			{
				src: ['src/**/*.hx', 'build_release.hxml'],
				hxml: 'build_release.hxml'
			}
		},

		copy:
		{
			assets:
			{
				files: [
					{
						cwd: 'assets/',
						expand: true,
						src: '**',
						dest: 'bin/assets/'
					}
				]
			},
			libs:
			{
				cwd: 'libs/',
				expand: true,
				src: '**',
				dest: 'bin/libs/'
			},
			html_dev:
			{
				cwd: 'html/',
				expand: true,
				src: 'index_dev.html',
				dest: 'bin/',
				rename: function (dest) {
					return dest + 'index.html';
				}
			},
			html_release:
			{
				cwd: 'html/',
				expand: true,
				src: 'index_release.html',
				dest: 'bin/',
				rename: function (dest) {
					return dest + 'index.html';
				}
			}
		},

		clean:
		{
			local: ['bin/']
		}
	});

	grunt.registerTask('default', ['clean:local', 'copy:assets', 'copy:libs', 'copy:html_dev', 'haxe:debug', 'connect', 'watch:debug']);
	grunt.registerTask('release', ['clean:local', 'copy:assets', 'copy:libs', 'copy:html_release', 'haxe:release', 'connect', "watch:release"]);
	grunt.registerTask('compiling', ['watch:haxe']);
}