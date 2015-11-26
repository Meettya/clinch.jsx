###
This is separate React jsx addon for Clinch processor
###
extend        = require 'whet.extend'
babel         = require 'babel-core'
# HACK - we are require preset and send it as object instead of jast name to avoid path problem
# https://phabricator.babeljs.io/T6692
preset_react  = require 'babel-preset-react'

extension = '.jsx'

get_options = (filename) ->
  ast       : false
  presets   : [preset_react]
  filename  : filename

processor = (data, filename, cb) ->
  try
    result = babel.transform data, get_options filename
  catch error
    error.filename = filename
    return cb error

  cb null, result.code, yes

builder = (raw_options) ->
  extension : extension
  processor : (data, filename, cb) ->
    options = extend {}, raw_options, get_options filename
    try
      result = babel.transform data, options
    catch error
      error.filename = filename
      return cb error

    cb null, result.code, yes

# dirty hack to use as object
builder.extension = extension
builder.processor = processor

module.exports = builder
