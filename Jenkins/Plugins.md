1. email-ext-plugin    
    
       https://www.jenkins.io/doc/pipeline/steps/email-ext/#email-extension-plugin   
           This plugin allows you to configure every aspect of email notifications. 
           You can customize when an email is sent, who should receive it, and what the email says.
           Email is sent to dynamic list of receipients instead of hardcoding email IDs for receipients.

       Example:

        pipeline {
            agent any
            stages{
                stage('checkout'){
                    steps{
                        echo "checking out the code from scm"
                    }
                }
            }
            post {
                failure {   #<- can be 'failure', 'success', 'always' etc
                    emailext body: "${currentBuild.currentResult}: Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n Further reference: ${env.BUILD_URL}",
                    recipientProviders: [[$class: 'DevelopersRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                    subject: "Jenkins Build ${currentBuild.currentResult}: Job ${env.JOB_NAME}"
                }
            }
        }           


2. Github folders: "github-branch-source"



3. Github integration


4. Github pull request

5. SSH Agent 

6. Blue ocean

7. Build Timeout

8. Cloudbeees docker hub/registery notification

9. Docker slaves

11. Workspace cleanup 

12. Environment injector plugin
