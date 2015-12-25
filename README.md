[![Dependency Status](https://gemnasium.com/Meettya/clinch.jsx.svg)](https://gemnasium.com/Meettya/clinch.jsx)
[![Build Status](https://travis-ci.org/Meettya/clinch.jsx.svg?branch=master)](https://travis-ci.org/Meettya/clinch.jsx)

# clinch.jsx

This is external addon for [clinch](https://github.com/Meettya/clinch) - CommonJS to browser packer to support React ```.jsx``` files.

This version **have ES2015 support**, with additional option `es2015 : yes`.

## How to use

    Clinch = require 'clinch'
    clinch_jsx = require 'clinch.jsx'

    # create packer object
    packer = new Clinch runtime : on
    # add plugin (chainable)
    packer.addPlugin clinch_jsx
    # or add plugin with es2015 option
    packer.addPlugin clinch_js6 es2015 : yes

For more information see main module documentation.

## Options

### es2015

Use options `es2015` to set up ES2015 support.

    packer.addPlugin clinch_js6 es2015 : yes

## About React version

React grow fast and add new features and drop old one in every new releases, so ```clinch.jsx``` have some version for all minor React version.

This is 0.14 version, used for React 0.14 branch, where ```react-tools``` was deprecated and ```.jsx``` compiled by [Babel](http://babeljs.io/). For options see [Babel options](http://babeljs.io/docs/usage/options/).
