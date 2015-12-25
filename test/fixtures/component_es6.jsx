module.exports = class HelloMessage extends React.Component {
  render() {
    const greet = 'Hello';
    let message = `${greet} ${this.props.name}`;
    
    return <div className="message">
        <p ref="p">{message}!!!</p>
      </div>;
  }
}
