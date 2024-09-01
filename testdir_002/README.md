
# Table of Contents

1.  [hugo-bootstrap-gallery](#org1d38330)
    1.  [file structure](#org4ea9e2a)
    2.  [Screenshot](#orgfc6054f)
    3.  [Installation](#orgc63aa9b)
    4.  [Usage](#org11b3d66)
    5.  [Configuration](#org133767a)
        1.  [Hugo](#orgf4e2ade)
    6.  [Questions, ideas, bugs, pull requests?](#org8d38ffe)



<a id="org1d38330"></a>

# hugo-bootstrap-gallery

A hugo theme using bootstrap 4, focussed on a gallery look

You can find a live site using this theme [here](<http://emacs.dyerdwelling.family/>).


<a id="org4ea9e2a"></a>

## file structure

hugo-bootstrap-gallery/

    ├── archetypes
    │   └── page.md
    ├── layouts
    │   ├── 404.html
    │   ├── _default
    │   │   ├── index.json
    │   │   ├── index.json.json
    │   │   ├── list.html
    │   │   ├── rss.xml
    │   │   ├── section.html
    │   │   ├── single.html
    │   │   └── terms.html
    │   ├── index.html
    │   └── partials
    │       ├── card.html
    │       ├── card-metas.html
    │       ├── disqus.html
    │       ├── error-404.html
    │       ├── footer.html
    │       ├── header.html
    │       ├── metas.html
    │       ├── scripts.html
    │       ├── search.html
    │       ├── share.html
    │       ├── single-metas.html
    │       └── tags.html
    ├── LICENSE.md
    ├── static
    │   ├── assets
    │   │   └── css
    │   └── scripts
    │       └── fixedsearch
    │           ├── fixedsearch.js
    │           └── fuse.js
    └── theme.toml


<a id="orgfc6054f"></a>

## Screenshot


<a id="orgc63aa9b"></a>

## Installation

    $ cd your_site_repo/
    $ mkdir themes
    $ cd themes
    $ git clone https://github.com/captainflasmr/hugo-bootstrap-gallery

See the [official Hugo themes documentation](<http://gohugo.io/themes/installing>) for more info.


<a id="org11b3d66"></a>

## Usage

This theme expects a relatively standard Hugo blog/personal site layout:

    .
    └── content
    	 ├── post
    	 |   ├── post1.md
    	 |   └── post2.md
    	 ├── page
    	 |   ├── about-me.md
    	 |   ├── license.md
    	 └── other_page.md

Just run \`hugo &#x2013;theme=hugo-bootstrap-gallery\` to generate your site!


<a id="org133767a"></a>

## Configuration

Please see the config file of the example site in this repo for details of confguration.


<a id="orgf4e2ade"></a>

### Hugo

An example of what your site's \`config.toml\` could look like. All theme-specific parameters are under \`[params]\` and standard Hugo parameters are used where possible.


<a id="org8d38ffe"></a>

## Questions, ideas, bugs, pull requests?

All feedback is welcome! Head over to the [issue tracker](<https://github.com/captainflasmr/hugo-bootstrap-gallery/issues>).
