pipeline {
    agent any
    environment {
        DOCKERHUB_USERNAME = credentials('abdelrhmanH21')
        DOCKERHUB_PASSWORD = credentials('abdoH2122@@')
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
                    sh 'npm run build'
                }
            }
        }

        stage('Dockerize') {
            steps {
                script {
                    // Build Docker image with a tag
                    sh "docker build --build-arg HOME=/home/jenkins -t abdelrhmanh21/nodejsapp:latest ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                        // Log in to Docker Hub securely
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKERHUB_USERNAME', passwordVariable: 'DOCKERHUB_PASSWORD')]) {
                        sh "echo $DOCKERHUB_PASSWORD | docker login --username $DOCKERHUB_USERNAME --password-stdin"
                    }

                    // Push the Docker image to Docker Hub
                    sh "docker push abdelrhmanh21/nodejsapp:latest"
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
