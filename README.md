# The Graylog documentation
[![Build Status](https://travis-ci.org/Graylog2/documentation.svg?branch=2.2)](https://travis-ci.org/Graylog2/documentation)

## Architecture

This is the repository that is used to create [docs.graylog.org](http://docs.graylog.org) running at [readthedocs](https://readthedocs.org/). After changes are pushed to the specific branches, the new pages are built. When the build runs without error, the new pages are available after some minutes.

The typical workflow to enable you to make changes to the documentation and preview them before you push the changes to this repository needs the following preparation. 

- clone the repository (to your workplace)
- initialize the virtual environment for python
- install the required python packages

After the above is done, changes can be made and previewed with the following

- create git branch for your changes
- change in the virtual environment
- make the modifications/additions
- run the build and check for errors
- push the branch to GitHub and create a pull request

Now a review of the changes is needed and finally, it will be merged, by the reviewer into the branch/version of the documentation you created the pull request for. Should the change be available in other versions of the documentation this should be written in the pull request that the reviewer can push this to the specific versions too.


## Building locally

### required software

- git
- python (including pip)
  - virtualenv (`pip install virtualenv`)
- make
- browser (to preview) 

#### Mac & Linux

It is very likely that you already have all needed software available, if not we recommend [homebrew](https://brew.sh/) for Mac users to install missing requirements and all Linux users should take their distribution package manager. 

##### first time preparation


Clone the repository to your workbench:

    # git clone https://github.com/Graylog2/documentation.git 


Create and enter the Python virtual environment:

    # cd documentation
    # virtualenv .
    # source ./bin/activate

Install [Sphinx](http://sphinx-doc.org), [the theme we are using](https://github.com/snide/sphinx_rtd_theme), and [sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild):

    # pip install -r requirements.txt


#### Windows

With Windows systems we recommend [chocolaty](https://chocolatey.org/) to install the requirements, should that not be possible to use - install [python](https://www.python.org/) and [git](https://git-scm.com/) from the project packages. 

##### Windows Installation in detail

_This can't be a complete guide, but this might give you some guidance._

The dependencie installation using [chocolaty](https://chocolatey.org/). The last, Github Desktop application is just to have a GUI available to manage the repository - it is not needed, but will make the work easier, same for the editor Notepad+. The commands need to be run in your administrator (power)shell.
    
	# choco install python
    # choco install git
    # choco install make
    # choco install github-desktop
	# choco install notepadplus

Use the Github Desktop application to clone the repository, by default this can be found in `C:\Users\$USERNAME\Documents\GitHub\$REPONAME`. Open (power)shell at this location and enable your user to run scripts

    # Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Bypass -Force;

Use the python package manager `pip` now to install `virtulenv`.

	# pip install virtualenv
	# virtualenv .
	# .\Scripts\activate
	# pip install -r requirements.txt
	

Once the above is done you are prepared to contribute to the documentation and preview the work live in your local browser. See the daily usage chapter.
	
### daily usage

How to work with git, create branches and push them will not be covered in this document. Change into the prepared directory, update the sources ([git pull](https://git-scm.com/docs/git-pull)), change into the virtual python environment (Linux/Mac `source ./bin/active`, Windows `.\Scripts\activate`) and start making the changes. If ready, build the static documentation and review the build process. 

Build the static documentation and open them in your browser:

    # make html
    # open _build/html/index.html


Build the documentation and automatically build them on any change:

    # make livehtml
    # open http://127.0.0.1:8000/

