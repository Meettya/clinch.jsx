
module.exports = class HelloMessage extends React.Component {
  render() {
    return <div className="message">
        <p ref="p">Hello {this.props.name}!!!</p>
      </div>;
  }
}