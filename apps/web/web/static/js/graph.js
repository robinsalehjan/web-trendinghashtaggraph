class Graph {
  constructor(callback) {
    let request = new XMLHttpRequest();
    request.open("GET", "https://trendinghashtaggraph.herokuapp.com/api/graph", true);

    request.onreadystatechange = function() {
      if (request.readyState == 4 && request.status == 200) {
        let response = request.response;
        let json = JSON.parse(response);

        let graph = [];
        for (let v of json) {
          var hashtag = {data: {id: v.hashtag}};
          graph.push(hashtag);

          for (let e of v.edges) {
            let edge = {data: {id: e}};
            graph.push(edge);

            let id_hashtag = hashtag.data.id.charAt(3);
            let id_edge = edge.data.id.charAt(6);
            let id_str = `${id_hashtag}->${id_edge}`;

            let connection = {data: { id: id_str, source: hashtag.data.id, target: edge.data.id}};
            graph.push(connection);
          }
        }
        callback(graph);
      }
    }

    request.send();
  }
}
export {Graph as default};