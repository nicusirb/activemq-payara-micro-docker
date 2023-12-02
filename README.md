# ActiveMQ Payara-Micro Docker

- Get ActiveMQ .rar file: 
`wget https://repo1.maven.org/maven2/org/apache/activemq/activemq-rar/5.16.4/activemq-rar-5.16.4.rar`

- Set `post-boot-commands.asadmin` in order to deploy the .rar and create default pool:
```sh
deploy --type rar --name activemq-rar /opt/payara/app/activemq-rar-5.16.4.rar
create-resource-adapter-config  --property ServerUrl=tcp\://amq\:61616:UserName='artemis':Password='artemis' activemq-rar

create-connector-connection-pool  --raname activemq-rar --connectiondefinition javax.jms.ConnectionFactory --ping true --isconnectvalidatereq true jms/myConnectionPool
create-connector-resource --poolname jms/ConnectionPool jms/ConnectionFactory
```

- Build the listener using `maven` docker image. Use `activemq-listener/build.sh` or run:
`docker run -it -v $(pwd):/app --workdir /app/activemq-listener maven mvn clean package`

- Set `post-boot-commands.asadmin` to deploy the listener
```sh
create-admin-object --raname activemq-rar --restype javax.jms.Queue --property PhysicalName=TESTQ jms/TESTQ
deploy --name TestQ /opt/payara/app/TestQ/target/activemq-listener-1.0-SNAPSHOT.jar
```

- Modify (volumes) and run the `docker-compose.yaml` file.


##### Enjoy queue-ing 😁

