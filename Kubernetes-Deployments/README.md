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
1. **Create a Kubernetes cluster** (e.g., using Minikube).
   
    For minikube you can find the steps here--> [Minikube](https://minikube.sigs.k8s.io/docs/start/?arch=%2Fwindows%2Fx86-64%2Fstable%2F.exe+download)
   
   
2. **Deploy the application using Kubernetes manifest files (YAML):** 

   ```bash
   kubectl apply -f k8s/backend.yaml
   kubectl apply -f k8s/frontend.yaml
   kubectl apply -f k8s/database.yaml
   ```

3. **Expose the services** if not already exposed in the manifest files:
   (Optional)
   ```bash
   kubectl expose deployment frontend --type=LoadBalancer --port=80
   kubectl expose deployment backend --type=LoadBalancer --port=8080
   ```
4. **Scale the application** (You can adjust the number of replicas either dynamically or by modifying the manifest files directly) :
   ```bash
   kubectl scale deployment frontend --replicas=3 #Adjust the no. of replicas if you want
   kubectl scale deployment backend --replicas=3 #Adjust the no. of replicas if you want 
   ```

