pipeline {
  agent {
    kubernetes {
      label 'php'
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
          script {
            docker.build('project-list:latest')
            docker.tag('project-list:latest', 'docker-releases.danelaw.co.uk/project-list:latest')
          }
        }
      }
    }
  }
  post {
    always {
      container('docker') {
        sh 'docker rmi docker-releases.danelaw.co.uk/project-list:latest || true'
        sh 'docker rmi project-list:latest || true'
      }
    }
  }
}
