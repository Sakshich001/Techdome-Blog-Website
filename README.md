
# TechDome Blog Application


## Introduction

TechDome is a blogging platform featuring a frontend developed with React and a backend powered by Node.js, integrated with Cloudinary for media management. The entire application runs within Docker containers and is orchestrated on a Kubernetes cluster. The deployment process is automated through the use of Terraform scripts.


## Architecture

The TechDome application follows a microservices architecture, consisting of three main services:

1. **Frontend**: A React application served by Nginx.
2. **Backend**: A Node.js application providing RESTful APIs connecting to Cloudinary and other services such as frontend and DB.
3. **Database**: A MongoDB instance for data storage.

## Architecture Diagram
![image](https://github.com/Sakshich001/Blog/assets/71651459/b9505e61-fbed-4b06-9e04-a57db97fe2a0)


## Deploy the Application using the Below Steps

### Docker

1. **Build the Docker images** for both frontend and backend:

   ```bash
   docker build -t username/<image-name> ./Techdome-frontend
   docker build -t username/<image-name> ./Techdome-backend
   ```

2. **Push the images** to Docker Hub or another container registry:
   
  

   ```bash
   docker push username/<image-name>
   docker push username/<image-name>
   ```

4. **Run the application using Docker Compose**:
   ```bash
   docker-compose up -d 
   ```
### For Deploying it on Kubernetes 
1. **Create a Kubernetes cluster** (e.g., using Minikube, GKE, EKS).
   
    For minikube you can find the steps here--> [Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download)
   
   Refer Documentation for other options
   
3. **Deploy the application using Kubernetes manifest files (YAML):** 

   ```bash
   kubectl apply -f k8s/backend.yaml
   kubectl apply -f k8s/frontend.yaml
   kubectl apply -f k8s/database.yaml
   ```

4. **Expose the services** if not already exposed in the manifest files:
   (Optional)
   ```bash
   kubectl expose deployment frontend --type=LoadBalancer --port=80
   kubectl expose deployment backend --type=LoadBalancer --port=8080
   ```
5. **Scale the application** (You can adjust the number of replicas either dynamically or by modifying the manifest files directly) :
   ```bash
   kubectl scale deployment frontend --replicas=3 #Change the no of replicas as you need
   kubectl scale deployment backend --replicas=3  #Change the no of replicas as you need
   ```


### Deploy on cloud (AWS) using Terraform
## Usage

1. Navigate to the desired environment directory (e.g., `environments/dev`)
2. Initialize Terraform in the `/environments/dev/' by running the following command:
    ```bash
    terraform init
    ```
3. Check you configuration by dry run i.e 
   ```bash
   terraform plan
   ```
   **This will display the resources scheduled for creation and deletion. An output file is provided in the repository at the following path: Terraform-Scripts/environments/dev/plan_output.json**

4. Apply the plan 
   ```bash
   terraform apply
   ```
5. You can delete your deployed infrastructure using Terraform:
   ```bash
   terraform destroy
   ``` 


## Challenges Faced

### 1.Difficulty Using Kubernetes Secrets Due to API Misreading Values (CORS Error)

When implementing Kubernetes secrets, the application faced a CORS error:

```
Cross-Origin Request Blocked: The Same Origin Policy disallows reading the remote resource at http://localhost:8080/api/get_blog. (Reason: CORS request did not succeed). Status code: (null).

```

**Cause**: The frontend application attempted to access the backend API without the necessary CORS configuration.

### 2. Faced challenges due to limited familiarity with writing tests for Terraform using the Terraform test framework.
**Solution**: Overcame this challenge by watching video tutorials and reading official documentation.

## Conclusion

This document offers a detailed summary of the TechDome blog application's architecture, deployment strategy, and step-by-step guidelines for building, deploying, and managing the platform. Adhering to the outlined procedures will help guarantee a seamless and secure deployment process.



