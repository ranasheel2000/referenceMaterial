Install Docker for Mac:
-----------------------
https://docs.docker.com/desktop/mac/install/

Enable Kubernetes in preferences (on docker for mac setup).

Download Helm Repo:
------------------
    tar -zxvf helm-v3.7.2-darwin-amd64.tar                          
    sudo mv darwin-amd64/helm /usr/local/bin/helm
	

Download Jenkins image and start jenkins pod:
---------------------------------------------
    docker pull jenkins/jenkins	

    kubectl run jenkins --image=jenkins/jenkins:latest 
    kubectl logs jenkins

Add volumes and mount local directory in pod as jenkins_home directory:
-----------------------------------------------------------------------
    apiVersion: v1
    kind: Pod
    metadata:
      name: jenkins
      namespace: default
    spec:
      containers:
      - image: jenkins/jenkins:latest
        name: jenkins
        volumeMounts:
        - name: jenkins-home
          mountPath: /var/jenkins_home
      volumes:
      - name: jenkins-home
        hostPath:
            path: "/Users/rana/jenkins_home"



    kubectl expose pod jenkins --name=jen-svc --port=8080 --target-port=8080 --type=NodePort -o yaml --dry-run=client >svc1.yml

    rana@Sheels-MacBook-Pro helm % cat svc1.yml                                                                                                         
    apiVersion: v1
    kind: Service
    metadata:
      creationTimestamp: null
      labels:
        run: jenkins
      name: jen-svc
    spec:
      ports:
      - port: 8080
        protocol: TCP
        targetPort: 8080
      selector:
        run: jenkins
      type: NodePort
    status:
      loadBalancer: {}
    rana@Sheels-MacBook-Pro helm % 



Use "localhost:nodePort" to access jenkins from local browser.
http://localhost:31243

Use password from the output of "kubectl logs jenkins" as adminPassword on Jenkins webpage http://localhost:31243 to login.
      #here jenkins is the pod name for jenkins
      
      
