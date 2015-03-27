
module.exports = function MyComponent(initialProps){
  return {
    state : { name : initialProps.name },
    render : function() {
      return <div className="message">
        <p ref="p">Hello {this.state.name}!!!</p>
      </div>
    }
  };
}
