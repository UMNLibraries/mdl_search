import 'babel-polyfill';
import React from 'react';
import ReactCitation from 'react-citation';

export default class Metadata extends React.Component {
  render() {
    return (
      <div>
        <div className="row citation">
          <ReactCitation items={this.props.config } />
        </div>
      </div>
    );
  }
}