<p align="center"><img src="images/logo_dark.png" alt="pyiron logo" width="150px;"/></p>

This is where we host the landing page for [pyiron](https://pyiron.org).

# Notes for developers + maintainers
## In general
The site is rendered using [jekyll](https://jekyllrb.com/), with [hydra](https://jekyll-themes.com/hydra/) as its base theme.
Mostly only superficial changes have been made to the hydra theme to create pyiron.org, so you will likely find everything
you need to know about the site in the documentation for hydra and jekyll.

## Running the server locally
### Install Ruby and Bundler
Bundler is a package manager for Ruby, similar to how Conda works for python.

To install on Mac OS X (ruby is already installed but can still be updated/managed using homebrew if you have it installed):
```
brew install ruby
gem install bundler
```

**(Using Conda)**
Alternatively, for those who want to use conda to configure the ruby environment on Mac OS X:
```
conda install clangxx_osx-64 ruby make rb-jekyll
```
on Linux:
```
conda install gxx_impl_linux-64 ruby make rb-jekyll
```

There is some trouble with installing ruby packages via conda: 
```
Ignoring eventmachine-1.2.7 because its extensions are not built. Try: gem pristine eventmachine --version 1.2.7
Ignoring ffi-1.11.1 because its extensions are not built. Try: gem pristine ffi --version 1.11.1
Ignoring http_parser.rb-0.6.0 because its extensions are not built. Try: gem pristine http_parser.rb --version 0.6.0
Ignoring sassc-2.3.0 because its extensions are not built. Try: gem pristine sassc --version 2.3.0
```
This is probably related to the pinning of the ruby version https://github.com/conda-forge/rb-eventmachine-feedstock/issues/3
but compiling locally seems to work fine. 

And for Mac Users you might have to activate Xcode first:
```
xcode-select --install
xcodebuild -license
```

### Install the website and serve it
```bash
git clone https://github.com/pyiron/pyiron.github.io.git
cd pyiron.github.io
bundle install  # you only have to repeat this if/when you change the underlying site layout.
bundle exec jekyll serve
```
Then go to the website at localhost (127.0.0.1:4000)

_N.B._ When you make changes to most files other than `_config.yml`, the local server will auto-refresh and immediately reflect the changes. For
changes made to `_config.yml` you will have to restart the server.

## Site layout

### `_config.yml`

As with most jekyll sites, a number of general settings can be controlled directly by editing the `_config.yml` file.
This is where we control e.g. the contact email address, the website colors, names of alumni contributors + steering committee, etc.
Variables stored in this file can be accessed in HTML pages using [liquid syntax](https://shopify.github.io/liquid/basics/introduction/),
beginning with the prefix `site.` For example,

```html
<!-- Create a link to write an email to our contact address -->
<p><a href="mailto:{{ site.email }}">{{ site.email }}</a></p>
```

To add a collection of data the site, create a .yml file under `_data/`, like the example collections we currently have in place (`affiliated_projects.yml`, `collaborators.yml`, etc.). Then access them with the liquid prefix `site.data.`:

To create a banner message on the home page (for important messages to share with visitors like workshop registration or site maintenance, etc.), simply set the `alert` variable in `_config.yml` similarly to the example provided in there.

```html
<!-- Create an HTML elemenmt for all the github bots listed for our site -->
{% for bot in site.data.github_bots %}
	<i class="bot" id="{{ bot }}"></i>
{% endfor %}
```

### HTML pages
_A quick note about `_layouts/`:_
All active pages on the site inherit their layout from `_layouts/default.html`, so changes made to this file will reflect throughout the entire site.

- **index.html**: pyiron's home page. Customized quite a bit.
- **team/index.html**: Pulls developer names and information from 
- **getting-started/index.html**: Basic instructions for starting and using the MyBinder instance.
- **news/index.html**: New updates for pyiron. Pulls from `news/_posts/`.
- **publications/index.html**: Papers published with pyiron, usually with MyBinder links. Pulls from `publications/_posts/`
- **privacy/index.html**: A very basic GDPR page about how we use visitors' data (we don't use visitors' data).
- **license/index.html**: Information about the license/credits for pyiron and this website.
- **404.html**: Renders when a searched page cannot be found.

### Code

There are two main types of code rendered on pyiron.org- snippets and cells.
Snippets are used to display non-interactive code that can be copy-pasted, like the
`conda install -c conda forge pyiron` on the homepage. A new snippet is created everywhere that
a normal code block is included in a markdown file:

\`\`\`sh
conda install -c conda forge
\`\`\`

The little tabs on the top left of the snippet are automatically created based on the syntax inside.
To add tab styles for new syntaxes, simply create a new class under `_sass/elements.scss`:

```sass
div.highlight.language-javascript::before {
	content: ".js";
}```

Cells can also be added in markdown files, but instead of a markdown code block, each cell
should be wrapped in a `{% highlight python %} {% endhighlight %}` statement. Right now python is the
only supported language, because that's what the Jupyter server is set up for.

{% highlight python %}
print("Hello world.")
{% endhighlight %}

When the above markdown is included in an HTML file, it will first create a non-interactive snippet similar
to those described above. The magic only happens when `_includes/juniper.html` is included at the foot of the
HTML file. `juniper.html` converts all elements that have been added via `{% highlight python %}` statements
into "juniper cells", which are editable jupyter cells that can actually be run on the MyBinder server linked
to the page. More on Juniper below.

To nicely format a markdown file containing plain text and code highlights, enclose the whole markdown file
in a `<div class="container notebook>`, like this example from the post.html layout:

```html
<div class="container notebook">
	<!-- this capture + markdownify nonsense is required to render
	markdown files within HTML files in jekyll/liquid. -->
	{% capture my_include %}{% include {{ page.code }} %}{% endcapture %}
	{{ my_include | markdownify }}
</div>
```

When in doubt, copy/paste the existing examples and modify just what you need.

#### Juniper <--> MyBinder connection

A few notes on how pyiron uses Juniper + MyBinder to run code cells embedded throughout the site:

[MyBinder](https://mybinder.org/) is the free Jupyter server on which we host many of our tutorial-style notebooks. Whenever a user visits the url of one of our MyBinder servers, MyBinder builds and launches a Docker instance where pyiron and all the extra packages are remotely installed.

[Juniper](https://github.com/ines/juniper) is a javascript library that lets us make remote calls to send input and receive output from one of these MyBinder instances. We set up the Juniper client in `_includes/juniper.html`:

```HTML
<!-- include the juniper minified source code.
We have customized this file, so please don't change it unless you
know what you are doing! -->
<script src="{{ 'js/juniper.min.js' | relative_url }}"></script>
```

```javascript
// Initialize the link to MyBinder via Juniper
new Juniper({
    repo: "{{ include.server }}",  // include.server usually set to pyiron/pyiron
    theme: 'monokai',  // syntax highlighting
    isolateCells: false,  // share variables among cells on page
    msgLoading: " ",  // don't show a loading message
})
```

Loosely speaking, the Juniper object has four statuses that pyiron.org listens for as events:

- **startup**: Booting up the MyBinder server. The actual events passed are named 'requesting-kernel' -> 'building' -> 'built' -> 'server-ready' -> 'launching' -> 'ready'
- **failed**: Indicates that some step in the startup event progression didn't work. Turns cell tab red.
- **executing**: A cell is running. Turns cell tab yellow.
- **cellExecuted**: An event that we manually added to `js/juniper.min.js` to indicate a cell has finished running. Turns cell tab green (success) or red (errored).

To create the `cellExecuted` event, I added these lines to the jupyterlab kernel's `_handleDone()` function inside of juniper.min.js:

```javascript
var event = new CustomEvent('cellExecuted', { detail: this._replyMsg }); // MA 
document.dispatchEvent(event); // MA
```

For more information about how each event is listened for and handled, see the EventListeners in `_includes/juniper.html`. For more information about how cells are styled, etc. see the various classes in `_sass/elements.css`.

**Important note:** 

### Blogs
the pyiron site technically hosts two blogs: `news` and `publications`. New posts are easy to add to either blog; just create a .md file under e.g. `news/_posts/` based on the examples that are already in there. The filename convention `YYYY-MM-DD-name-of-post.md` is unfortunately quite strict because that's how jekyll orders the posts. If you use a different date format your post will probably not show up.

The 3 most recent posts in `news/` items are also added automatically to the home page.

You can control the number of blog posts shown per page under pyiron.org/news/ and pyiron.org/publications/ by the variable `posts-per-page` in `_config.yml`.

### Stylesheets
The stylesheets for the site are written in Scss (sassy css), under `_sass`. The main colors of the site are stored in `_sass/variables.scss` (they are also stored in `_config.yml`, since these two files apparently cannot transfer variables to each other). Other than that, there is more or less one Scss file for each "main" HTML file, although technically all stylesheets are imported for each page that's based on `default.html`. This is because `default.html` includes `css/screen.scss`, which in turn imports all the Scss files under `_sass`.

However, I have used `_sass/elements.scss` in some places as a kind of "overarching" stylesheet.

### External links
We use external links for the documentation ([readthedocs](https://pyiron.readthedocs.io/en/latest/)), the [MyBinder instance](https://mybinder.org/v2/gh/pyiron/pyiron/master), and the "Imprint" (another GDPR thing; here we just point to MPIE's Imprint page).

### Images
All the main images like our logos are stored in `images/`, except the file `favicon.png` in the root folder, which sets the image shown in browser tabs.

The news cards on the front page are automatically decorated with images based on their category. If a new category is created for a post, a corresponding image (with the name news-icon-category_name.png) should be added to `images/`. Otherwise the default news icon will be used for that post.

### Downloads
Right now there is only one file to download directly from the site:
- `BSD_LICENSE`: The BSD License for pyiron

## Future features (not set up)
### Google analytics
If we ever want to set up google analytics, just add the key to the `_config.yml` file. That's all you should have to do, and it will be added to each page individually. However, we would also have to include some notice of this cookie usage in our privacy statement.
