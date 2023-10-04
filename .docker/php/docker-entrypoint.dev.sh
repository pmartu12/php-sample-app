#!/bin/bash
set -e

[ -d /app/vendor ] || composer install
symfony local:server:start --no-tls --port=80
