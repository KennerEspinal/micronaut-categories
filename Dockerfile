# Primera fase: compilación
FROM openjdk:17-jdk-slim AS build
WORKDIR /app
COPY . .
RUN ./mvnw package -DskipTests

# Segunda fase: empaquetado
FROM openjdk:17-jdk-slim
COPY --from=build /app/target/microservicio-categorias-*.jar /microservicio-categorias.jar
EXPOSE 8080
CMD ["java", "-Dcom.sun.management.jmxremote", "-Xmx128m", "-jar", "/microservicio-categorias.jar"]

