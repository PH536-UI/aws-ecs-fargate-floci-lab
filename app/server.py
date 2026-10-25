#!/usr/bin/env python3
"""Tiny dependency-free HTTP app for the ECS/Fargate local lab."""
from http.server import BaseHTTPRequestHandler, HTTPServer
from datetime import datetime, timezone
import json
import os

APP_NAME = os.getenv("APP_NAME", "ph-ecs-demo")
APP_VERSION = os.getenv("APP_VERSION", "dev")
PORT = int(os.getenv("PORT", "8080"))

class Handler(BaseHTTPRequestHandler):
    def _reply(self, status, payload):
        body = json.dumps(payload, indent=2).encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        now = datetime.now(timezone.utc).isoformat()
        if self.path in ("/", "/health"):
            self._reply(200, {"status": "ok", "application": APP_NAME, "version": APP_VERSION, "timestamp": now, "environment": "local-floci"})
        else:
            self._reply(404, {"status": "not_found", "path": self.path, "timestamp": now})

    def log_message(self, fmt, *args):
        print("%s - %s" % (self.address_string(), fmt % args))

if __name__ == "__main__":
    print(f"Starting {APP_NAME} version {APP_VERSION} on port {PORT}")
    HTTPServer(("0.0.0.0", PORT), Handler).serve_forever()
