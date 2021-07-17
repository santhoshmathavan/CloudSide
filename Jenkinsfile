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
          /* Finally, we'll push the image with two tags:
                   * First, the incremental build number from Jenkins
                   * Second, the 'latest' tag.
                   * Pushing multiple tags is cheap, as all the layers are reused. */
          docker.withRegistry('gcr.io/cedar-oath-316105/cloudside-app', 'gcr-jenkins') {
              dockerImage.push("${env.BUILD_NUMBER}")
              dockerImage.push("latest")
          }
        }
      }
    }
  }
}
