div = React.createFactory 'div'
p   = React.createFactory 'p'

module.exports = class HelloMessage extends React.Component 

  render: ->
    div className : "message",
      p ref : "p", 
        "Hello #{@props.name}!!!"
