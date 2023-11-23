pipeline {
    agent any
    environment {
        dockerImage = 'nodeapp'
        dockerContainerName = 'nodecontainer'
        dockerPortMapping = '8080:3000'
        dockerTag = 'latest'
        DOCKER_HOME = '/home/jenkins'  
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')
        SONARQUBE_SCANNER_HOME = tool 'SonarQube Scanner'
    }
    
    stages {
        stage('Install Dependencies') {
            steps {
                script {
                    sh 'npm i --legacy-peer-deps'
                    sh 'npm install'
                    sh 'npm ci'
                }
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh 'npm run test:unit'
                }
            }
        }

        stage('Build') {
            steps {
                script {
                    // Build Docker image
                    sh "docker build --build-arg HOME=${DOCKER_HOME} -t nodeapp:${dockerTag} ."
                }
            }
        }
      
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('sonarqube-token') {
                        sh "${tool('SonarQubeScanner')}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Dockerize') {
            steps {
                script {
                    // Tag Docker image for consistency
                    sh "docker tag nodeapp:${dockerTag} abdelrhmanh21/nodeapp:${dockerTag}"
                }
            }
        } 

    stage('Push to Docker Hub') {
        steps {
                script {
                    sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh 'docker push abdelrhmanh21/nodeapp:${dockerTag}'
                }
          }
    }
}

    post {
        success {
            script {
                archiveArtifacts 'dist/**' // Adjust the path based on your project structure
            }
        }
    }
}
