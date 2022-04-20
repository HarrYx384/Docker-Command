FROM openjdk:8-jdk-alpine

ARG JAR_FILE
ARG SERVICE_PORT
ENV JAVA_OPTS=""
ENV JMX_VERSION=0.12.0

# Install and configure JMX exporter
RUN mkdir -p /opt/jmx
COPY ./devops/jmx-config.yaml /opt/jmx/config.yaml
RUN wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/${JMX_VERSION}/jmx_prometheus_javaagent-${JMX_VERSION}.jar -O /opt/jmx/jmx.jar

# Install grpc_health_probe binary
RUN GRPC_HEALTH_PROBE_VERSION=v0.4.5 && \
    wget -qO/bin/grpc_health_probe https://github.com/grpc-ecosystem/grpc-health-probe/releases/download/${GRPC_HEALTH_PROBE_VERSION}/grpc_health_probe-linux-amd64 && \
    chmod +x /bin/grpc_health_probe

COPY ${JAR_FILE} /app.jar
# Expose service port, grpc metric port, jmx exporter port
EXPOSE ${SERVICE_PORT} 9101 9110
CMD java -Dlog4j.configuration=file:/opt/log4j-properties/log4j.properties -XX:+UseG1GC $JAVA_OPTS -javaagent:/opt/jmx/jmx.jar=9101:/opt/jmx/config.yaml -jar -Dconfig-file=/opt/config-properties/config.properties /app.jar 
