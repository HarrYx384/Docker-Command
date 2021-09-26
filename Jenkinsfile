pipeline{
  environment{
  properties([parameters([choice(choices: ['main', 'check', 'master'], name: 'BRANCH')])])
  }
agent any
  stages{
  stage("source code")
    steps{
      echo "choose the branch ${params.BRANCH}"
      git url: "https://github.com/HarrYx384/Docker-Command.git ${params.BRANCH}"
    }
  }
}
