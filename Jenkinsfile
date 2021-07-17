pipeline {
  environment {
    registry = "gcr.io/cedar-oath-316105/cloudside-app"
    registryCredential = 'gcr-jenkins'
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
          docker.withRegistry(' https://us.gcr.io', 'gcr-jenkins') {
              dockerImage.push("${env.BUILD_NUMBER}")
              dockerImage.push("latest")
          }
        }
      }
    }
  }
}
