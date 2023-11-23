pipeline {
    agent any
    environment {
        dockerImage = 'nodeapp'
        dockerContainerName = 'nodecontainer'
        dockerPortMapping = '8080:3000'
        dockerTag = 'latest'
        DOCKER_HOME = '/home/jenkins'  
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

        stage('Dockerize') {
            steps {
                script {
                    // Tag Docker image for consistency
                    sh "docker tag nodeapp:${dockerTag} abdelrhmanH21/nodejsApp:${dockerTag}"
                }
            }
        } 
    }

    stage('Push to Docker Hub') {
        steps {
            script {
                // Use Docker Hub credentials stored in Jenkins
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                    // Log in to Docker Hub
                    sh "docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD"

                    // Push the Docker image to Docker Hub
                    sh "docker push abdelrhmanH21/nodejsApp:${dockerTag}"
                }
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
