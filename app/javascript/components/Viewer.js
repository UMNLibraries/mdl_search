import 'babel-polyfill';
import React from 'react';
import Borealis from 'react-borealis';

export default class Viewer extends React.Component {
  render() {
    return (
      <div>
        <div className="row">
          <Borealis
            basename=""
            config={this.props.config } />
        </div>
      </div>
    );
  }

}
