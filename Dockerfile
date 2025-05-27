# Estágio de build
FROM gradle:8.13-jdk17 AS build
WORKDIR /app
COPY . ./
RUN gradle clean build -x test --no-daemon

# Estágio final
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/build/libs/msdiscovery-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8761
ENV JAVA_OPTS="-Xms256m -Xmx512m"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]