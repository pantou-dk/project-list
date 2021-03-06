pipeline {
  options {
    disableConcurrentBuilds()
    timeout(time: 1, unit: 'HOURS')
    timestamps()
  }
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
    
    stage('Deploy') {
      when {
        branch 'master'
      }
      
      steps {
        container('openshift') {
          script {
            sh 'oc new-project project-list --display-name="Project List" --description="A listing of Danelaw projects" || true'
            sh 'oc apply -n project-list -f kubernetes/configmap/site-conf.yaml'
            sh 'oc apply -n project-list -f kubernetes/service/project-list.yaml'
            sh 'oc apply -n project-list -f kubernetes/route/project-list.yaml'
            sh 'oc apply -n project-list -f kubernetes/deploymentconfig/project-list.yaml'
            sh 'oc rollout -n project-list cancel dc/project-list || true'
            sh 'oc rollout -n project-list latest dc/project-list'
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
