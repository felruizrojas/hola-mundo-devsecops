pipeline {
    agent any

    environment {
        APP_NAME   = 'hola-mundo'
        DEPLOY_DIR = '/var/jenkins_home/despliegues/test/hola-mundo'
    }

    stages {
        stage('Build') {
            steps {
                echo 'Etapa BUILD: validando y empaquetando el código fuente...'
                sh '''
                    chmod +x app/hola.sh tests/test_hola.sh
                    bash -n app/hola.sh
                    bash -n tests/test_hola.sh
                    rm -rf dist && mkdir -p dist
                    tar -czf dist/${APP_NAME}-${BUILD_NUMBER}.tar.gz -C app hola.sh
                    ls -l dist/
                '''
                archiveArtifacts artifacts: 'dist/*.tar.gz', fingerprint: true
            }
        }

        stage('Test') {
            steps {
                echo 'Etapa TEST: ejecutando pruebas unitarias...'
                sh './tests/test_hola.sh'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Etapa DEPLOY: desplegando en entorno de prueba...'
                sh '''
                    mkdir -p "${DEPLOY_DIR}"
                    tar -xzf dist/${APP_NAME}-${BUILD_NUMBER}.tar.gz -C "${DEPLOY_DIR}"
                    echo "Aplicación desplegada en: ${DEPLOY_DIR}"
                    "${DEPLOY_DIR}/hola.sh" "Entorno de Prueba"
                '''
            }
        }
    }

    post {
        success { echo "Pipeline #${BUILD_NUMBER} finalizado con ÉXITO" }
        failure { echo "Pipeline #${BUILD_NUMBER} FALLÓ - revisar la consola" }
    }
}
