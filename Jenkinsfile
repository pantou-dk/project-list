pipeline {
  agent {
    kubernetes {
      label any
      defaultContainer 'jnlp'
      yamlFile 'build-pod.yaml'
    }
  }
  stages {
    stage('Build') {
      steps {
        container('php') {
          sh 'php -v'
        }
      }
    }
    
    stage('Docker Build') {
      steps {
        container('docker') {
          sh 'docker -v'
        }
      }
    }
  }
}
