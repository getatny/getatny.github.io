pipeline {
  agent {
    docker 'node:10.17'
  }
  stages {
    stage('checkout') {
      steps {
        checkout([$class: 'GitSCM', branches: [[name: env.GIT_BUILD_REF]], userRemoteConfigs: [[url: env.GIT_REPO_URL, credentialsId: env.CREDENTIALS_ID]]])
      }
    }
    stage('build') {
      steps {
        sh 'npm install'
        sh 'npm run build'
      }
    }
    stage('push') {
      steps {
        dir(path: './public') {
          sh 'git init'
          sh 'git config --global user.name "Matthew Wang"'
          sh 'git config --global user.email "wangmaozhu@foxmail.com"'
          sh 'git add .'
          sh 'git commit -m "update blog"'
          sh "git push --force --quiet 'https://${env.TOKEN}@e.coding.net/matthew-wang/matt-coding.git' master:master"
        }

      }
    }
  }
}
