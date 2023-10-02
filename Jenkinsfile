pipeline {
    agent any

//    stages {
//        stage('Sync s3') {
            steps {
                script {
//                    withCredentials([
//                        [$class: 'AmazonWebServicesCredentialsBinding', 
//                         accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
//                         secretKeyVariable: 'AWS_SECRET_ACCESS_KEY', 
//                        credentialsId: '62c39d7a-6bdc-474a-9d4f-7c379e3b7c9d']
//                    ]) 
                        {
                        sshagent(['c125c30b-4451-4560-9498-c41d193cb266']) {
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
                    sshagent(['c125c30b-4451-4560-9498-c41d193cb266']) {
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
                    sshagent(['c125c30b-4451-4560-9498-c41d193cb266']) {
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

