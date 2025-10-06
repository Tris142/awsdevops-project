FROM tomcat:latest
RUN cp -R /usr/local/tomcat/awsdevops/maven-web-app.war /usr/local/tomcat/awsdevops
COPY target/maven-web-app.war /usr/local/tomcat/awsdevops
