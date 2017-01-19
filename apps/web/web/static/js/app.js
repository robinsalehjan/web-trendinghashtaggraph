import "phoenix_html"
import Cytoscape from 'cytoscape';
import Graph from "./graph";

export var App = {
  run: function() {
    let graph = new Graph();

    var cytopscape = new Cytoscape({
      container: document.getElementById("cy"),
      boxSelectionEnabled: false,
      autounselectify: true,

      layout: {
        name: 'cose',
        ready: function(){},
        stop: function(){},
        animate: true,
        animationThreshold: 100,
        refresh: 20,
        fit: true,
        padding: 10,
        boundingBox: undefined,
        randomize: true,
        componentSpacing: 50,
        nodeOverlap: 0,
        idealEdgeLength: function( edge ){ return 500; },
        edgeElasticity: function( edge ){ return 500; },
        nestingFactor: 1,
        gravity: 10,
        numIter: 100,
        initialTemp: 10,
        coolingFactor: 0.25,
        minTemp: 1.0,
        useMultitasking: true
      },

      style: [
        {
          selector: 'node',
          style: {
            'height': 10,
            'width': 10,
            'background-color': '#0084b4',
            'label': 'data(id)'
          }
        },

        {
          selector: 'edge',
          style: {
            'width': 5,
            'opacity': 1.0,
            'line-color': '#0084b4'
          }
        }
      ],

      elements: graph
    })
  }

}