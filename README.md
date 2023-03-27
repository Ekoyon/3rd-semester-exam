# 3rd-semester-exam
## Deployment of microservices-based architectur on Kubernetes using IaC deployment tool (terraform) to ensure services are eployed fast.

### OVERVIEW
- Provision a web app with nginx/httpd frontendproxy and a database backend
- Provision the Socks Shop microservice application

### Technologies used
- AWS console
- AWS CLI
- Kubectl
- Terraform
- Helm
- ArgoCD
- Github
- Docker

### Steps for deployment
- Install and set up each technologies

### AWS CLI
- Now we first configure the AWS CLI
aws configure
- You get prompted to put in details, fill in the required details

### Terraform
- Open a text editor and create a directory (folder). In the directory, create a provider.tf file; mine looks like this:
![provider.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/provider.tf.png) 

- Create an S3 bucket to store the state file. Doing this allows for sharing when working with a team.
The script is created in a "backend.tf" file.

![backend.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/backend.tf.png),

- Create scripts that provisions vpc, subnets, internet gateways, security groups etc
![vpc.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/vpc.tf.png)

- The next script creates the EKS cluster and IAM roles and their policies. The role allows the cluster to access other AWS resources. My "eks.tf" file looks like this:
![eks.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/eks.tf.png),
![eks.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/eks2.tf.png),
![eks.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/eks3.tf.png),

- Create a "variable.tf" file, "output.tf" and "local.tf" files to house variables and expeced outputs
![variable.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/variabler.tf.png),
![outputs.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/outputs.tf.png)
![locals.tf](https://github.com/Ekoyon/3rd-semester-exam/blob/main/locals.tf.png)

### TERMINAL
- Initialized terrafform in this directory. It downloads the dependencies that are specified in "providers.tf" and "backend.tf" files.
terraform init

- Plan the scripts
terraform plan

- Apply the scripts. This creates every infrasture specified
terraform apply

Next we add the cluster to the local kubectl configuration
aws eks --name <THE_CLUSTER_NAME> --region <THE_CLUSTER_REGION>

### ARGOCD
- Create a namespace for the argocd application deployment
kubectl create namespace argocd

- Add the ARGOCD Helm repository
helm repo add argo-cd https://argoproj.github.io/argo-helm -n argocd

- Install Argo CD
helm install argocd argo-cd/argo-cd -n argocd

- Test/confirm installation
kubectl get services -n argocd

- Expose the service
kubectl patch svc argocd-server -p '{"spec": {"type": "LoadBalancer"}}' -n argocd

- Get login password and then login to Argo CD
kubectl get secret argocd-initial-admin-secret -o jsonpath"{.data.password}" |base64 -d; echo -n argocd

the link to your external ip is copied after running: kubectl get -svc -n argocd and run in a browser
login to argocd

![argocd login page](https://github.com/Ekoyon/3rd-semester-exam/blob/main/argocd.ekoyon.me%20.jpg)

Use loadbalancer to login to the argocd application

### ARGOCD Application
- Open the repository management menu on the screen and then click on the "Repositories tab to connect github repo to argocd
- connect using https
- Add repository url and click on "connect"

### SETTING UP Apps of Apps
- Click on "New App"
- Fill the parameters like so :
- Application name: root
- Project: default
- Sync Policy: automatic
- Sync options: autocreate namespace
- Cluster: hhtps://Kubernetes.default.sv
- repo url: select the repo url
- path: select path
- Revision: HEAD
- click on "create"
- Click on "sync"

### Deploy other Apps using helm charts(because it is easier)
the apps are in the repo specified so we clickon "sync"

base app (app of choice)
![pretty web app](https://github.com/Ekoyon/3rd-semester-exam/blob/main/motion.ekoyon.me%20.jpg)

prometheus:
![prometheus page](https://github.com/Ekoyon/3rd-semester-exam/blob/main/prometheus.ekoyon.me%20.jpg)

grafana
![grafana page](https://github.com/Ekoyon/3rd-semester-exam/blob/main/grafana.ekoyon.me%20.jpg)


#### reference: https://faun.pub/continous-deployments-of-kubernetes-applications-using-ago-cd-gitops-helm-charts-9df917caa2e4
