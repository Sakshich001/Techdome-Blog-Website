### Deploy on cloud (AWS) 
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
