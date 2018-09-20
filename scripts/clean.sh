#!/bin/bash

find /silk-v3-decoder/www/voice -mtime +10 -name "*.*" -exec rm {} \;
