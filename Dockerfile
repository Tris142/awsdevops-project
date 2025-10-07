FROM tomcat:10-jdk17
MAINTAINER tris146 <trishalaababu@gmail.coms>
EXPOSE 8080
COPY target/maven-web-app.war /usr/local/tomcat/webapps/maven-web-app.war
