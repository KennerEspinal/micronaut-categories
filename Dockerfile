# Primera fase: compilación
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -DskipTests

# Segunda fase: empaquetado
FROM openjdk:17-jdk-slim AS final
WORKDIR /app
COPY --from=build /app/target/microservicio-categorias-*.jar /app/microservicio-categorias.jar
EXPOSE 8080

# Instalación de dockerize
RUN apt-get update && \
    apt-get install -y wget && \
    wget https://github.com/jwilder/dockerize/releases/download/v0.6.1/dockerize-linux-amd64-v0.6.1.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.6.1.tar.gz && \
    rm dockerize-linux-amd64-v0.6.1.tar.gz

CMD ["dockerize", "-wait", "tcp://mn_category:5432", "-timeout", "10s", "java", "-Dcom.sun.management.jmxremote", "-Xmx128m", "-jar", "/app/microservicio-categorias.jar"]