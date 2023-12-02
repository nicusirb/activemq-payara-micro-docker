#!/bin/sh

docker run -it -v $(pwd):/app --workdir /app/activemq-listener maven mvn clean package