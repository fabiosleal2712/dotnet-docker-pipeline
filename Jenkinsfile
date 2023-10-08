pipeline {
    agent any

    stages {
        stage('Sync s3') {
            steps {
                script {
                    withCredentials([
                        [$class: 'AmazonWebServicesCredentialsBinding', 
                         accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
                         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY', 
                         credentialsId: '62c39d7a-6bdc-474a-9d4f-7c379e3b7c9d']
                    ]) {
                        sshagent(['7fd9e024-a02b-4745-ae76-2921235d9980']) {
                            sh '''
                            ssh -o StrictHostKeyChecking=no ubuntu@15.228.239.133"
                                export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
                                export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}
                                aws s3 sync s3://docker-image3424644/dotnetbinario/ /home/ubuntu/directory
                            "
                            '''
                        }
                    }
                }
            }
        }

        stage('Run Docker load image dotnetbinario') {
            steps {
                script {
                    sshagent(['7fd9e024-a02b-4745-ae76-2921235d9980']) {
                        sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@15.228.239.133"
                            cd /home/ubuntu/directory
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
                        ssh -o StrictHostKeyChecking=no ubuntu@15.228.239.133"
                            cd /home/ubuntu/directory
                            sudo yum install git -y
                            git clone https://github.com/fabiosleal2712/dotnet-docker-pipeline.git || true
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
                        ssh -o StrictHostKeyChecking=no ubuntu@15.228.239.133"
                            docker network create network-dotnet
                            cd /home/ubuntu/directory/dotnet-docker-pipeline
                            git pull
                            docker-compose up -d
                        "
                        '''
                    }
                }
            }
        }
    }
}
