FROM gradle:4.3-jdk as builder
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle
RUN ./gradlew --no-daemon build
COPY . .
RUN ./gradlew --no-daemon build

FROM java:8-jre
WORKDIR /root
COPY --from=builder /home/gradle/build/distributions/docker-multi-stage-build-test.tar .
RUN tar xf docker-multi-stage-build-test.tar
CMD docker-multi-stage-build-test/bin/docker-multi-stage-build-test
