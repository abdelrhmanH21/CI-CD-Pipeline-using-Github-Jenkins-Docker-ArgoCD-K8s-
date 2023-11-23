pipeline {
    agent any
    environment {
        dockerImage = 'nodeapp'
        dockerContainerName = 'nodecontainer'
        dockerPortMapping = '8080:3000'
        dockerTag = 'latest'
        DOCKER_HOME = '/myapp'  
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
                    // Build Docker image
                    sh "docker build --build-arg HOME=${DOCKER_HOME} -t ${dockerImage}:${dockerTag} ."
                }
            }
        }
      stage('Run Container') {
            steps {
                script {
                    // Run Docker container
                    sh "docker run -d --name ${dockerContainerName} -p ${dockerPortMapping} ${dockerImage}:${dockerTag}"
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
