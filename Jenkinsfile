pipeline {
    agent any

    environment {
        DOCKER_HOME = '/home/jenkins'
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')
        GIT_COMMIT_HASH = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
        DOCKER_TAG = "latest-${GIT_COMMIT_HASH}"
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
                    // Build Docker image with the new tag
                    sh "docker build --build-arg HOME=${DOCKER_HOME} -t nodeapp:${DOCKER_TAG} ."

                    // Tag Docker image for consistency
                    sh "docker tag nodeapp:${DOCKER_TAG} abdelrhmanh21/nodeapp:${DOCKER_TAG}"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    // Push the updated Docker image to Docker Hub
                    withCredentials([string(credentialsId: 'DOCKERHUB_CREDENTIALS', variable: 'DOCKERHUB_CREDENTIALS')]) {
                        sh 'echo $DOCKERHUB_CREDENTIALS | docker login -u abdelrhmanh21 --password-stdin'
                        sh "docker push abdelrhmanh21/nodeapp:${DOCKER_TAG}"
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
}
