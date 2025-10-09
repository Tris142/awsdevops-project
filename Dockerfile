FROM tomcat:10-jdk17
LABEL maintainer="Trishalaa <trishala@gmail.com>"

RUN rm -rf /usr/local/tomcat/webapps/*

COPY target/maven-webapp-deploy.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=30s \
  CMD curl -f http://localhost:8080/ || exit 1
