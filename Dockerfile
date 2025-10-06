FROM tomcat:latest
MAINTAINER https://tomcat.apache.org/tomcat-8.5-doc/deployer-howto.html
EXPOSE 8080
COPY target/maven-web-app.war /usr/local/tomcat/webapps/maven-web-app.war
