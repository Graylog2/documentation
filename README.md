# The Graylog documentation
[![Build Status](https://travis-ci.org/Graylog2/documentation.svg?branch=2.0)](https://travis-ci.org/Graylog2/documentation)

## Building locally

Create and enter the Python virtual environment:

    # virtualenv .
    # source ./bin/activate

Install [Sphinx](http://sphinx-doc.org), [the theme we are using](https://github.com/snide/sphinx_rtd_theme), and [sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild):

    # pip install -r requirements.txt

Build the static documentation and open them in your browser:

    # make html
    # open _build/html/index.html

Build the documentation and automatically build them on any change:

    # make livehtml
    # open http://127.0.0.1:8000/

### Fedora Linux 22 and higher

    # sudo dnf install -y python-sphinx python-sphinx_rtd_theme
