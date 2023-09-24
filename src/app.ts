// Starts a server using the Bun library.
// The server listens on a specified port or a default port and handles incoming requests.
// If the request path is "/", it responds with "Hello, World!".
// If the request path is "/health", it responds with "OK".
// For any other request path, it responds with "404!".
export function start() {
  let port = process.env.PORT || 1271;
  console.log(`Starting HTTP server at http://127.0.0.1:${port}.`);

  Bun.serve({
    port: port,
    fetch(req) {
      const url = new URL(req.url);
      if (url.pathname === "/") return new Response("Hello, World!");
      if (url.pathname === "/health") return new Response("OK");
      return new Response("404!");
    },
  });
}
