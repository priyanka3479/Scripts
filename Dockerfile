FROM openjdk:11-jdk

ARG APP_USER
ARG APP_DIR
ADD docker/harden.sh / 
RUN chmod 700 /harden.sh \
	&& sh -c "/harden.sh" \
	&& rm -rf /harden.sh

VOLUME /tmp
EXPOSE 8080
#EXPOSE 8444
ADD target/*.jar app.jar
ENV JAVA_OPTS=""
USER $APP_USER
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -jar /app.jar" ]