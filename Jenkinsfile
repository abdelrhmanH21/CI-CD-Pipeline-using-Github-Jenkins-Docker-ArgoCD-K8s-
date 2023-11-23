pipeline {
    agent any
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
