# Etapa 1: Build
FROM maven:3.9.7-eclipse-temurin-21 AS builder

WORKDIR /app

# Copiamos el código fuente
COPY . .

# Compilamos el proyecto y generamos el WAR
RUN mvn clean package -DskipTests

# Etapa 2: Servidor Tomcat
FROM tomcat:10-jdk21-corretto

# Quitamos las apps por defecto de Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# Copiamos el WAR generado al directorio de despliegue
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Puerto que expone Tomcat
EXPOSE 8080

CMD ["catalina.sh", "run"]
