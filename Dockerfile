#in the Jenkinsfile 2......... we have already built the artifact  (.jar file)
# now we will make a docker image from it
# for making docker image..................(1.  what is needed to build..........2 what is neeeded to run)............... only the second  part to be done as  artifact already built
# moreover folder structure needs to understood
# our parent folder is  java-maven-sonar-argocd-helm-k8s/spring-boot-app
# after build the arifacts is at java-maven-sonar-argocd-helm-k8s/spring-boot-app/target/spring-boot-web.jar
# we will need only runtime for artifact to run
#

FROM eclipse-temurin:17-jre                    # run time to run the application
ARG artifact=target/spring-boot-web.jar        #path to artifacts defined as a variable
WORKDIR /opt/app                                # set a workdir............ usually from where the application will run
COPY ${artifact}  myapp                          #now copy the artifact  to workdir and renamed it
ENTRYPOINT ["java", "-jar", "myapp"]              # run the application



#thus we  can build a docker image  using this Dockerfile
#docker build -t <dockerhubusername>/<applicationname>:<version>
#after building the image it can be pused to repository................. or docker hub
#for pushing 1  docker login....OR.....repositiry login   .........then push..............
