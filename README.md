## The Graylog documentation

#### Building locally

Install [Sphinx](http://sphinx-doc.org)

    $ easy_install -U Sphinx

Install [the theme we are using](https://github.com/snide/sphinx_rtd_theme):

    $ pip install sphinx_rtd_theme

Build the docs and open them in your browser:

  $ cd documentation
  $ make html
  $ open _build/html/index.html
