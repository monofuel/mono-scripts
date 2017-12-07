#!/bin/bash
set -euo pipefail

bash -n *.bash
bash -n setup/*.bash

# TODO assert that all scripts start with set -euo pipefail