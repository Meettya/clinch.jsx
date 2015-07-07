###
This is separate React jsx addon for Clinch processor
###
extend  = require 'whet.extend'
babel   = require 'babel-core'

extension = '.jsx'

processor = (data, filename, cb) ->
  try
    result = babel.transform data, { filename, ast : false }
  catch error
    error.filename = filename
    return cb error

  cb null, result.code, yes

builder = (raw_options) ->
  extension : extension
  processor : (data, filename, cb) ->
    options = extend {}, raw_options, { filename, ast : false }
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
