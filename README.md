# Ottawa Assembly

[Ottawa Assembly](http://ottawa.infilexfil.com/) is a calendar of tech and startup events happening in Ottawa, Canada. Maintained by [ESWAT](http://github.com/ESWAT/) and friends.

This is a [React](http://facebook.github.io/react/)-based web app that pulls the XML version of the Ottawa Tech Events calendar hosted by Google. Files are generated using [CEKTOP](http://eswat.ca/cektop).

It will remain very much a work-in-progress until I can work out some of the finer details: proper display of multi-day events, cleaner presentation of event summaries, making sure event details fit in the viewport, etc.

## Start

You can see the generated files in the `gh-pages` branch. But to hack on your own you will need [Node.js](http://nodejs.org/download/).

- `npm install -g grunt-cli` if you do not have the Grunt CLI installed
- `npm install` for remaining dependencies
- `grunt` starts a server in development mode while `grunt preview` starts it in preview mode, which optimizes your files as if you were ready to publish (both can be seen at [localhost:8000](http://localhost:8000/))
- `grunt build` will build production-ready files without publishing to GitHub Pages or updating the `gh-pages` branch
- `grunt shipit` will update your `gh-pages` branch with production-ready files and publish to GitHub Pages
- *Optional*: Install the [LiveReload extension for Chrome](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei) so your browser automatically refreshes whenever you make changes in development mode

## License

Ottawa Assembly is released under the [MIT License](LICENSE).
