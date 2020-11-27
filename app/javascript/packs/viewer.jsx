import React from 'react'
import ReactDOM from 'react-dom'
import Borealis from 'react-borealis';

document.addEventListener('turbolinks:load', () => {
    const node = document.getElementById('viewer_data')
    const viewerNode = document.getElementById('react-borealis-viewer')
    const config = JSON.parse(node.getAttribute('viewerConfig'))
    const initialPath = node.getAttribute('initialPath')
    ReactDOM.render(
        <Borealis
            basename=""
            initialPath={initialPath}
            config={config} />,
            viewerNode.appendChild(document.createElement('div')),
        );
})

