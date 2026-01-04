FROM eclipse-temurin:17-jdk-jammy

WORKDIR /app

COPY target/spring-petclinic-4.0.0-SNAPSHOT.jar app.jar

EXPOSE 9000

ENTRYPOINT ["java","-jar","app.jar"]
