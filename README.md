[![Dependency Status](https://gemnasium.com/Meettya/clinch.jsx.svg)](https://gemnasium.com/Meettya/clinch.jsx)
[![Build Status](https://travis-ci.org/Meettya/clinch.jsx.svg?branch=master)](https://travis-ci.org/Meettya/clinch.jsx)

# clinch.jsx

This is external addon for [clinch](https://github.com/Meettya/clinch) - CommonJS to browser packer to support React ```.jsx``` files.

## How to use

    Clinch = require 'clinch'
    clinch_jsx = require 'clinch.jsx'

    # create packer object
    packer = new Clinch runtime : on
    # add plugin (chainable)
    packer.addPlugin clinch_jsx

For more information see main module documentation.

## About React version

React grow fast and add new features and drop old one in every new releases, so ```clinch.jsx``` have some version for all minor React version.