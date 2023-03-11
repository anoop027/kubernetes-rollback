pipeline {
    agent any
    parameters {
      string defaultValue: 'client', description: 'enter image tag name', name: 'ImageTag'
    }
    
    
    stages {
        stage('git checkout') {
         steps{
            git 'https://github.com/anoop027/kubernetes-rollback'
         }
        }
        
        stage('change permission') {
         steps{
            sh 'sudo chmod 777 /var/lib/jenkins/workspace/EKS-rollback/roll/chtag.sh'
            sh 'sudo chmod 777 /var/lib/jenkins/workspace/EKS-rollback/roll/rollback.sh'
            sh 'sudo chmod 777 /var/lib/jenkins/workspace/EKS-rollback/roll/dep.yml'
         }
        }
            
        stage('change tag') {
            steps{
             sh 'sudo /var/lib/jenkins/workspace/EKS-rollback/roll/chtag.sh $ImageTag'               
            }
        }


        stage('EKS deploy/rollback') {
         steps {
            sshagent(['eks-master-ssh']) {
                sh 'scp -o StrictHostKeyChecking=no /var/lib/jenkins/workspace/EKS-rollback/roll/rollback.sh /var/lib/jenkins/workspace/EKS-rollback/roll/dep.yml ubuntu@172.31.19.232:/home/ubuntu/roll/'
                sh 'ssh ubuntu@172.31.19.232 kubectl apply -f /home/ubuntu/roll/dep.yml'
                sh 'sleep 10'
                sh 'ssh ubuntu@172.31.19.232 /home/ubuntu/roll/rollback.sh'

            }
          }
        }
    
}
}
