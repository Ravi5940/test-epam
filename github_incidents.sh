#!/usr/bin/env bash
set -e

# Fetch summary from GitHub Status API
curl -s https://www.githubstatus.com/api/v2/summary.json