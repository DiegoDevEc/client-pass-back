# Etapa 1: Build
FROM maven:3.9.7-eclipse-temurin-11 AS builder

WORKDIR /app

# Copiamos el código fuente
COPY . .

# Compilamos el proyecto y generamos el WAR
RUN mvn clean package -DskipTests

# Etapa 2: Servidor Tomcat
FROM tomcat:9-jdk11-temurin

# Quitamos las apps por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el WAR generado al directorio de despliegue
COPY --from=builder /app/target/ROOT_rest.war /usr/local/tomcat/webapps/ROOT.war

# Puerto que expone Tomcat
EXPOSE 80

CMD ["catalina.sh", "run"]
