#!/bin/bash

# output ExecStartPost logs for systemd process
journalctl -xe
systemctl status

# look at environment for process
sudo cat /proc/$pid/environ
