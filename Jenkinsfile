pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ameysalvi5675/spring-petclinic"
    }

    stages {

        stage('Maven Build') {
            steps {
                sh './mvnw clean package -DskipTests -Dcheckstyle.skip=true'
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $DOCKER_IMAGE:latest .'
            }
        }

        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'USER',
                    passwordVariable: 'PASS'
                )]) {
                    sh '''
                    docker login -u $USER -p $PASS
                    docker push $DOCKER_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy to EC2') {
            steps {
                sh '''
                docker stop app || true
                docker rm app || true
                docker run -d -p 80:80 --name app $DOCKER_IMAGE:latest
                '''
            }
        }
    }
}
