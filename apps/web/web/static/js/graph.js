class Graph {
  constructor() {
    let request = this.send_request();
    let response = request.response;
    let obj = this.parse_request(response);
    let representation = this.construct_graph(obj);
    return representation;
  }

  send_request() {
    let request = new XMLHttpRequest();
    request.open("GET", "https://trendinghashtaggraph.herokuapp.com/api/graph", false);
    request.send();
    return request;
  }

  parse_request(response) {
    if (typeof response !== 'string') {
      let msg = `Expected: string\nGot: ${typeof(data)}`
      throw new TypeError(msg);
    }
    let obj = JSON.parse(response);
    return obj;
  }

  construct_graph(data) {
    if (typeof data !== 'object') {
      let msg = `Expected: object\nGot: ${typeof(data)}`
      throw new TypeError(msg);
    }

    let elements = [];

    for (let v of data) {
      var hashtag = {data: {id: v.hashtag }};
      elements.push(hashtag);

      for (let e of v.edges) {
        let edge = {data: { id: e }};
        elements.push(edge);

        let id_hashtag = hashtag.data.id.charAt(3);
        let id_edge = edge.data.id.charAt(6);
        let id_str = `${id_hashtag}->${id_edge}`;

        let connection = {data: { id: id_str, source: hashtag.data.id, target: edge.data.id}};
        elements.push(connection);
      }
    }
    return elements;
  }
}

export {Graph as default};