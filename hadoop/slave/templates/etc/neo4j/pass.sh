#!/bin/bash
/usr/bin/curl -H "Content-Type: application/json" -X POST -d '{"password":"password"}' -u neo4j:neo4j http://localhost:7474/user/neo4j/password >> /tmp/curl.txt
/usr/bin/curl -H "Content-Type: application/json" -X POST -d '{"password":"neo4j"}' -u neo4j:password http://localhost:7474/user/neo4j/password >> /tmp/curl.txt