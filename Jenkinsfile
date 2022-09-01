pipeline {
    agent any
    parameters {
        string defaultValue: '300', name: 'INTERVAL'
    }
    environment {
        CRED = credentials('credentials')
        CONFIG = credentials('config')
    }

    stages {
        stage('Init') {
            steps {
                cleanWs()
                sh "docker kill aws || true"
                sh "docker rm aws || true"
                sh "docker rmi -f aws || true"
            }
        }
        stage('SCM') {
            steps {
                git url: 'https://github.com/ranazrad/machineScanner.git', branch: 'master'
            }
        }
        stage('Build') {
            steps {
                sh "cat $CRED | tee credentials"
                sh "cat $CONFIG | tee config"
                sh "docker build -t aws ."
            }
        }
        stage('Deploy') {
            steps {
                sh "docker run -itd --name aws --env INTERVAL=${params.INTERVAL} aws"
            }
        }
        stage('Logs') {
            steps {
                sh "docker logs aws > aws.txt"
                sh "docker ps -a"
                sh "docker ps -a >> aws.txt"
                sh "cat aws.txt"
            }
        }
    }
}
