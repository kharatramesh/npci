FROM ubuntu AS a1
RUN apt update -y
RUN apt install maven -y
WORKDIR /project1
COPY . .
RUN mvn clean package -Dmaven.test.skip=true


FROM openjdk:8-jdk-alpine
COPY --from=a1 /project1/target/*.jar  app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]