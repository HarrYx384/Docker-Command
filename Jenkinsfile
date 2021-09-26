pipeline{
  environment{
  properties([parameters([choice(choices: ['main', 'master', 'feature'], name: 'BRANCH')])])
  }
agent any
  stages{
  stage("source code")
    steps{
      echo "choose the branch ${params.BRANCH}"
      git url: "
    }
  }
}
