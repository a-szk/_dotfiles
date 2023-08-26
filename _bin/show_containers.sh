#!/bin/sh

docker ps --format 'table {{ .Image }},{{ .Names }},{{ .Status }}' | column -s"," -t

