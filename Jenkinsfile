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
          }
        }
      }
    }
    
    stage('Docker Push') {
      when {
        branch 'master'
      }
      
      steps {
        container('docker') {
          script {
            docker.build('docker-releases.danelaw.co.uk/project-list:latest').push()
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
