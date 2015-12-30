###
This is separate React jsx addon for Clinch processor
###
extend        = require 'whet.extend'
babel         = require 'babel-core'
# HACK - we are require preset and send it as object instead of jast name to avoid path problem
# https://phabricator.babeljs.io/T6692
preset_react  = require 'babel-preset-react'
preset_es2015 = require 'babel-preset-es2015'

extension   = '.jsx'

get_options = (filename, is_es2015_used) ->
  presets = if is_es2015_used
    [preset_react, preset_es2015]
  else
    [preset_react]

  ast       : no
  presets   : presets
  filename  : filename

builder     = (raw_options = {}) ->
  # babel unhappy with unknown options, wipe it 
  use_es2015 = no
  if raw_options.es2015?
    use_es2015 = raw_options.es2015
    delete raw_options.es2015

  currnet_extention = extension
  if raw_options.extension?
    currnet_extention = raw_options.extension
    delete raw_options.extension

  extension : currnet_extention
  processor : (data, filename, cb) ->
    options = extend {}, raw_options, get_options filename, use_es2015
    try
      result = babel.transform data, options
    catch error
      error.filename = filename
      return cb error

    cb null, result.code, yes

processor   = (data, filename, cb) ->
  builder().processor data, filename, cb

# dirty hack to use as object
builder.extension = extension
builder.processor = processor

module.exports = builder
