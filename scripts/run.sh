#!/bin/bash
date
crond
/usr/local/openresty/bin/openresty -g "daemon off;"
