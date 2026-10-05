# Built by .github/workflows/deploy.yml and pushed to Artifact Registry.
#
# Two stages: Maven builds the Boot fat jar, a JRE-only image runs it as a
# non-root user. The port comes from $PORT at RUNTIME (application.properties:
# server.port=${PORT:8080}), never baked in.
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /src
COPY pom.xml ./
RUN mvn -B -q dependency:go-offline
COPY src ./src
RUN mvn -B -q package -DskipTests && cp target/app-*.jar /app.jar

FROM eclipse-temurin:21-jre AS runtime
ARG BUILD_ID=""
WORKDIR /app
ENV PORT=8080 BUILD_ID=$BUILD_ID
RUN useradd -r -u 10001 app
COPY --from=build /app.jar /app/app.jar
USER app
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
