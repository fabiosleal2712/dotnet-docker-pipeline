pipeline {
    agent any

    stages {
        stage('Sync s3') {
            steps {
                script {
                    sshagent(['7fd9e024-a02b-4745-ae76-2921235d9980']) {
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
                    sshagent(['7fd9e024-a02b-4745-ae76-2921235d9980']) {
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

        stage('clonar o repos') {
            steps {
                script {
                    sshagent(['7fd9e024-a02b-4745-ae76-2921235d9980']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@3.228.20.167 "
                            rm -rf /home/ec2-user/terraform-pipeline-jenkins
                            cd /home/ec2-user/directory
                            sudo yum install git -y
                            git clone https://github.com/fabiosleal2712/terraform-pipeline-jenkins.git
                        "
                        '''
                    }
                }
            }
        }



        stage('Run Another Docker Container on EC2') {
            steps {
                script {
                    sshagent(['7fd9e024-a02b-4745-ae76-2921235d9980']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ec2-user@3.228.20.167 "
                            docker network create network-dotnet
                            cd /home/ec2-user/terraform-pipeline-jenkins
                            docker-compose up -d
                        "
                        '''
                    }
                }
            }
        }
    }
}
