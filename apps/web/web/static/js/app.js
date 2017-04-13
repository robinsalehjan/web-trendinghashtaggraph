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
        ready: undefined,
        stop: undefined,
        animate: true,
        animationThreshold: 100,
        refresh: 20,
        fit: true,
        padding: 5,
        boundingBox: undefined,
        randomize: true,
        componentSpacing: 100,
        nodeOverlap: 0,
        idealEdgeLength: function(edge) { return 400; },
        edgeElasticity: function(edge) { return 500; },
        nestingFactor: 0.25,
        gravity: 10,
        numIter: 50,
        initialTemp: 10,
        coolingFactor: 0.25,
        minTemp: 1.0,
        useMultitasking: true
      },

      style: [
        {
          selector: 'node',
          style: {
            'height': 70,
            'width': 70,
            'font-size': '40',
            'color': 'white',
            'background-color': 'white',
            'label': 'data(id)'
          }
        },

        {
          selector: 'edge',
          style: {
            'width': 10,
            'opacity': 1.0,
            'line-color': '#40e0d0'
          }
        }
      ],
      elements: graph
    })
  }
}