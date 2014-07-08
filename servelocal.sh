#!/bin/bash
#
# Serve the site locally on port 4000. Assumes that `jekyll` has been
# installed per instructions at http://jekyllrb.com/docs/installation
#
jekyll serve --watch --drafts --config _config.yml,_config-local.yml $@
