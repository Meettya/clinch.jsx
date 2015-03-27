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

module.exports = { extension, processor }
