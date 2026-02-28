const express = require("express");
const { exec } = require("child_process");

const app = express();
const PORT = process.env.PORT || 3000;

app.disable("x-powered-by");

app.get("/api/status", (req, res) => {
  res.json({
    status: "operational",
    timestamp: new Date().toISOString(),
    uptime: process.uptime().toFixed(2)
  });
});

app.get("/api/health", (req, res) => {
  res.json({
    services: {
      nginx: "ok",
      node: "ok"
    }
  });
});

app.get("/api/metrics", (req, res) => {
  exec("/home/deploy/metrics.sh", (err, stdout) => {
    if (err) return res.status(500).json({ error: "metrics_unavailable" });
    try {
      res.json(JSON.parse(stdout));
    } catch {
      res.status(500).json({ error: "metrics_unavailable" });
    }
  });
});

app.listen(PORT, "127.0.0.1", () => {
  console.log(`API listening on 127.0.0.1:${PORT}`);
});