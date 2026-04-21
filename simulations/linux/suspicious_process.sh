#!/bin/bash

echo "[+] Simulating suspicious process execution"

bash -c "curl http://example.com" &
bash -c "nc -lvp 4444" &

sleep 2

echo "[+] Simulation completed"