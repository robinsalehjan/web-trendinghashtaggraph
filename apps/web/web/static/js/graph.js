class Graph {
  constructor() {
    let request = this.send_request();
    let response = request.response;
    let data = this.parse_request(response);
    let representation = this.construct_graph(data);
    return representation;
  }

  send_request() {
    let request = new XMLHttpRequest();
    request.open("GET", "http://localhost:4000/api/graph", false);
    request.send();
    return request;
  }

  parse_request(response) {
    if (!response.includes("200")) {
      let msg = `Expected: String\nGot:${typeof(response)}`
      throw new TypeError(msg);
    }
    let obj = JSON.parse(response);
    let data = obj[200];
    return data;
  }

  construct_graph(data) {
    if (!(data instanceof Object)) {
      let msg = `Expected: Object\nGot:${typeof(data)}`
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