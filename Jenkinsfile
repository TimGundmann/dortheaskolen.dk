pipeline {
    agent any

    tools {
        nodejs 'node 15'
    }
    stages {
        stage('Prepare') {
            steps{
                git url: 'https://github.com/TimGundmann/dortheaskolen.dk.git', branch: 'main'
                sh 'npm install'
            }                
        }

        stage('Test') {
            steps{
                wrap([$class: 'Xvfb', displayName: 1]) {
                    sh "ps -aux | grep Xvfb"
                    sh "export DISPLAY=:1"
                    sh "ng test --watch false"
                }
            }                
        }

        stage('Build') {
            steps{   
                sh 'ng build --aot --prod --output-hashing none'
            }
        }
        stage('Deploy') {
            steps{
                sh 'docker-compose stop'
                sh 'docker-compose build'
                sh 'docker-compose up -d'
            }
        }
    }

  post {
      failure {
            step([$class: 'Mailer', notifyEveryUnstableBuild: true, recipients: emailextrecipients([[$class: 'CulpritsRecipientProvider'], [$class: 'RequesterRecipientProvider']])])      
        }
  }    
}
