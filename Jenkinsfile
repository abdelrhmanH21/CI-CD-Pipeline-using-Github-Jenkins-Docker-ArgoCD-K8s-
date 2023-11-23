pipeline {
    agent any
    stages {
        stage('Install Dependencies') {
            steps {
              script {
                def nodeVersion = '14.17.6' // Replace with your desired Node.js version
                tool 'NodeJS ' + nodeVersion
        }
    }

        }
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
                sh 'npm ci'
            }
        }

        stage('Run Tests') {
            steps {
                sh 'npm run test:unit'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }
    }
}

