import React from 'react'
import ReactDOM from 'react-dom'
import Borealis from 'react-borealis';

document.addEventListener('DOMContentLoaded', () => {
    const node = document.getElementById('viewer_data')
    const viewerNode = document.getElementById('react-borealis-viewer')
    const config = JSON.parse(node.getAttribute('viewerConfig'))
    ReactDOM.render(
        <Borealis
            basename=""
            config={config } />,
            viewerNode.appendChild(document.createElement('div')),
        );
})

