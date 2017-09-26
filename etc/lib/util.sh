#!/bin/bash

color() {
  # Usage: color <color> <text>

  local prefix="\e["

  local default="1;0m"
  local red="1;31m"
  local green="1;32m"
  local yellow="1;33m"
  local blue="1;34m"
  local cyan="1;36m"

  local text="$1"
  local color="${default}"

  if [ "$#" -eq 2 ]; then
    text="$2"
    case "$1" in
      red | green | yellow | blue | cyan)
        eval color="\$$1"
        ;;
      default | *)
        color="${default}"
        ;;
    esac
  fi

  printf "${prefix}${color}${text}${prefix}${default}"
}

logger() {
  # Usage: logger <log_type> <message>

  local log_type="$1"
  local message="$2"
  local color=""
  local text=""

  case ${log_type} in
    INFO)
      color=blue
      ;;
    SUCCESS)
      color=green
      ;;
    ERROR)
      color=red
      ;;
    WARN)
      color=yellow
      ;;
    *)
      color=default
      log_type=""
      message="$1"
      ;;
  esac

  if [ -n "${log_type}" ]; then
    text="[${log_type}] ${message}"
  else
    text="${message}"
  fi

  color cyan "[$(date +'%Y/%m/%d %H:%M:%S')] "
  color "${color}" "${text}"
  printf "\n"
}

log_info()    { logger INFO    "$*"; }
log_success() { logger SUCCESS "$*"; }
log_warn()    { logger WARN    "$*"; }
log_error()   { logger ERROR   "$*" 1>&2; }
log()         { logger DEFAULT "$*"; }
