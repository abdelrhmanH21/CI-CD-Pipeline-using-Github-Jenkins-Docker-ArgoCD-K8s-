pipeline {
    agent any

    environment {
        DOCKER_HOME = '/home/jenkins'
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')
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
                    // Use the short Git commit hash as the Docker image tag
                    def gitCommitHash = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    def dockerTag = "latest-${gitCommitHash}"

                    // Build Docker image with the new tag
                    sh "docker build --build-arg HOME=${DOCKER_HOME} -t nodeapp:${dockerTag} ."

                    // Tag Docker image for consistency
                    sh "docker tag nodeapp:${dockerTag} abdelrhmanh21/nodeapp:${dockerTag}"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Push the updated Docker image to Docker Hub
                    withCredentials([string(credentialsId: 'DOCKERHUB_CREDENTIALS', variable: 'DOCKERHUB_CREDENTIALS')]) {
                        sh 'docker login -u abdelrhmanh21 --password-stdin <<< $DOCKERHUB_CREDENTIALS'
                        sh "docker push abdelrhmanh21/nodeapp:${dockerTag}"
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
}
