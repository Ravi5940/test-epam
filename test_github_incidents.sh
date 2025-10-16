#!/usr/bin/env bash
set -e

# Run the main script and capture output
json_output=$(bash ./github_incidents.sh)

# Parse the latest incident (if any)
incident=$(echo "$json_output" | jq '.incidents[0]')
if [[ "$incident" == "null" ]]; then
    echo "No incidents found."
else
    body=$(echo "$incident" | jq -r '.body')
    status=$(echo "$incident" | jq -r '.status')
    updated_at=$(echo "$incident" | jq -r '.updated_at')

    echo "### Latest GitHub Incident" > incident_summary.txt
    echo "**Status:** $status" >> incident_summary.txt
    echo "**Last Updated:** $updated_at" >> incident_summary.txt
    echo "**Body:**" >> incident_summary.txt
    echo "$body" >> incident_summary.txt

    # Output to GITHUB_STEP_SUMMARY if running in GitHub Actions
    if [[ -n "$GITHUB_STEP_SUMMARY" ]]; then
        cat incident_summary.txt >> "$GITHUB_STEP_SUMMARY"
    fi

    # Also print to console
    cat incident_summary.txt
fi