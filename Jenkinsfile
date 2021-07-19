pipeline {
  environment {
    registry = "gcr.io/cedar-oath-316105/cloudside-app"
    registryCredential = 'cedar-oath-316105'
    dockerImage = ''
  }
  agent any
  stages {
    stage('Building Docker Image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Push Image To GCR') {
      steps{
        script {
          docker.withRegistry('https://gcr.io','gcr:cedar-oath-316105') {
              dockerImage.push("${env.BUILD_NUMBER}")
              dockerImage.push("latest")
          }
        }
      }
    }
  }
}
