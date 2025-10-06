FROM tomcat:latest
RUN cp -R /usr/local/tomcat/webapps/maven-web-app.war
COPY target/maven-web-app.war /usr/local/tomcat/webapps/maven-web-app.war
