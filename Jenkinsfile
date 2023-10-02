pipeline {
    agent any

    stages {
        stage('Sync s3') {
            steps {
                script {
                    sshagent(['4713449b-a476-429a-afe4-f0bec4086c9a']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@3.228.20.167 "
                            aws s3 sync s3://docker-image3424644/dotnetbinario/ /home/ec2-user/directory
                        "
                        '''
                    }
                }
            }
        }

        stage('Run Docker load imagem dotnet') {
            steps {
                script {
                    sshagent(['4713449b-a476-429a-afe4-f0bec4086c9a']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@3.228.20.167 "
                            cd /home/ec2-user/directory
                            docker load -i dotnetbinario.tar
                        "
                        '''
                    }
                }
            }
        }

        stage('Run Another Docker Container on EC2') {
            steps {
                script {
                    sshagent(['4713449b-a476-429a-afe4-f0bec4086c9a']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@3.228.20.167 "
                            docker network create network-dotnet
                            docker run -d -p 5001:8080 --name dotnet dotnetbinario
                            docker-compose up -d
                        "
                        '''
                    }
                }
            }
        }
    }
}
