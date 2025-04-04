#!/bin/bash
# Wrapper script to force Rails to use PostgreSQL 16's pg_dump
exec /usr/local/opt/postgresql@16/bin/pg_dump "$@"
