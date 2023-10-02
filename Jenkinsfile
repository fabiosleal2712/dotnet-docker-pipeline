pipeline {
    agent any

    stages {
        stage('Sync s3') {
            steps {
                script {
                    sshagent(['c125c30b-4451-4560-9498-c41d193cb266']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@3.228.20.167 "
                            export AWS_ACCESS_KEY_ID=${AWS_CREDENTIALS_USR}
                            export AWS_SECRET_ACCESS_KEY=${AWS_CREDENTIALS_PSW}
                            aws s3 sync s3://docker-image3424644/dotnetbinario/ /home/ec2-user/directory
                        "
                        '''
                    }
                }
            }
        }

    }
}
