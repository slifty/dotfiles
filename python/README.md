Python deserves its own readme because it is SIMPLY THAT SPECIAL.

First, here's a good guide that captures a reasonable python setup: https://www.rootstrap.com/blog/how-to-manage-your-python-projects-with-pipenv-pyenv/

We use that setup for the most part, and in particular use:

1. pyenv to manage python versions
2. pipenv to manage pip packages

The dotfile bootstrap will install the latest version of Python (3.x) at the point of install and use it as the system default, but you can swap things around as desired.

You can specify a version of python to use in a given directory by populating `.python-version`

pipenv is installed via homebrew.