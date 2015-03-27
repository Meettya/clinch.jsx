###
This is separate React jsx addon for Clinch processor
###
React = require 'react-tools'

extension = '.jsx'

processor = (data, filename, cb) ->
  try
    content = React.transform data
  catch error
    error.filename = filename
    return cb error

  cb null, content, yes

builder = (options) ->
  extension : extension
  processor : (data, filename, cb) ->
    try
      content = React.transform data, options
    catch error
      error.filename = filename
      return cb error

    cb null, content, yes

# dirty hack to use as object
builder.extension = extension
builder.processor = processor

module.exports = builder
