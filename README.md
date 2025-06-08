I have docker engine installed on windows 10 ..............  and i have Jenkins running (java prerequisite) in WSL ubuntu.............
i wanted to build a java springboot application........
git repository         https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git............>>java-maven-sonar-argocd-helm-k8s/spring-boot-app
so as i know to build the java applictaion ant or maven needed which i installed on WSL.
then  for static code anaylysis i launched the a container for sonarqube.......accessible from localhost:9000................ generated asecurity token from server...
i configured the sonar scanner and sonar server in jenkins..............(u can check steps in monitoring tools notes...
in jenkins i installed pipeline stage plugin.......
the i started building ................ jenkinsfile is present in the jenkinsfile 



For the second project same application but with docker agnet for building
jenkinsfile2 is presnt you can check that
the issue i faced is while docker build image stage................ because we are ina container  which niether have docker installed nor access to dockerr on host(windows)
args= -v var/run/docker.sock:var/run/docker.sock           ................although it can be used to access docker daemon on host
But it will not work because docker host is windows not a linux machine.

However i was able to acheive all prior stages............checkout, build, sonar scan.............(as sonar was running on another container....... i run that sonar container using  docker network.............docker create network mynetwork.............docker run -d --name sonarqube --network  mynetwork      sonarqube:lts..........
also i did run the docker agent(container for build with same network

args '--network mynetwork --user root -v /var/run/docker.sock:/var/run/docker.sock

final agent block

docker {
        image 'maven:3.9.6-eclipse-temurin-17'
        args '--network mynetwork --user root -v /var/run/docker.sock:/var/run/docker.sock'  
        }
    }

