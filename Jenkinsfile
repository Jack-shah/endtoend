// below project was build while docker on windows,jenkins on wsl ubuntu, sonar on dokcer container and mvn was configured for auto download.
// Also this project was build  when all the tools were installed on WSL...........
pipeline {
    agent any

    tools {
        maven 'mvn' // Ensure this matches the name in Global Tool Configuration
        // sonarQubeScanner 'SonarScanner' // Uncomment if using SonarScanner CLI
    }

    stages {
        stage('Checkout the source code') {
            steps {
                git branch: 'main', url: 'https://github.com/iam-veeramalla/Jenkins-Zero-To-Hero.git'
            }
        }

        stage('Build the application') {
            steps {
                sh '''
                    ls -a
                    cd java-maven-sonar-argocd-helm-k8s/spring-boot-app
                    mvn clean package
                    ls -lh target
                '''
            }
        }

        stage('SonarQube Analysis') {
            when {
                expression { 2 == 3 } // This condition disables the stage
            }
            steps {
                withCredentials([string(credentialsId: 'sonartoken', variable: 'SONAR_AUTH_TOKEN')]) {
                    dir('java-maven-sonar-argocd-helm-k8s/spring-boot-app') {
                        sh '''
                            mvn sonar:sonar \
                              -Dsonar.projectKey=your-project-key \
                              -Dsonar.host.url=http://localhost:9000 \
                              -Dsonar.login=$SONAR_AUTH_TOKEN
                        '''
                    }
                }
            }
        }
    }
}
