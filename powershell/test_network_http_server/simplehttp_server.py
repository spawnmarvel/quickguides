import http.server
import socketserver

PORT = 8080
Handler = http.server.SimpleHTTPRequestHandler

# simplehttp_server.py in the same directory as index.html because by default the SimpleHTTPRequestHandler will look for a file named index.html in the current directory.
# Passing an empty string as the ip address means that the server will be listening on any network interface (all available IP addresses).
def simp_http():
    try:
        with socketserver.TCPServer(("localhost", PORT), Handler) as httpd:
            print("serving at port", PORT)
            httpd.serve_forever()
    except KeyboardInterrupt as e:
        print("closing" + str(e))
        httpd.server_close()

if __name__ == '__main__':
    simp_http()

    