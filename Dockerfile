#Maven with jdk8
FROM maven:3.6.3-jdk-8

VOLUME /tmp

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /home/app/pom.xml  
#RUN ["mvn", "dependency:resolve"]
#RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /home/app/src
RUN ["mvn", "clean", "install"]

RUN ["ls", "/home/app/target"]
RUN ["pwd"]
RUN ["ls", "-ltrh", "/home/app/target/myspringboot.jar"]

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/home/app/target/myspringboot.jar" ]
