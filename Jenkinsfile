pipeline {
    agent any
    environment {
        NODE_VERSION = '14.17.6' // Replace with your desired Node.js version
    }
    stages {
        stage('Set Node.js Version') {
            steps {
                script {
                    tool 'NodeJS ' + env.NODE_VERSION
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
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
    }

    post {
        success {
            archiveArtifacts 'dist/**' // Adjust the path based on your project structure
        }
    }
}
