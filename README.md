
# Cloud Resume Challenge

This project involves the use of cloud deployment techniques and DevOps practices, including CI/CD and Infrastructure as Code, to develop and maintain a dynamic resume website. It serves as an application of web development skills and an exploration of cloud service capabilities.

Details of the Cloud Resume Challenge can be found [here](https://cloudresumechallenge.dev/docs/the-challenge/aws/ "cloudresume").

## Built with
1. Frontend

- **[React-cv](https://github.com/sbayd/react-cv "react-cv")**: Selected for its simplicity, React-cv forms the basis of the frontend, providing a streamlined resume component.

2. AWS Resources
- **Lambda**
  - **Visitor Count Function**: Increments a visitor count while ensuring each visitor's uniqueness by checking IP addresses stored in DynamoDB.
  - **Notification Function**: Handles message customization and sending them based on CloudWatch alarms, using sns topic.
- **DynamoDB**
  - One for unique visitor IP addresses.
  - Another for tracking the visitor count.
- **S3**
    - one for frontend s3 hosting 
    - Another for lambda script code storage
- **API Gateway**: Acts as a secure endpoint for the frontend to invoke Lambda functions.
- **CloudFront**: Delivers the static website content from S3, improving load times and security.
- **ACM (AWS Certificate Manager)**: Secures the website with HTTPS.
- **CloudWatch & SNS topic**: Monitors lambda error, invocation, api gateway latency.
- **Route 53**: Manages DNS records, facilitating domain management and HTTPS certificate validation.

3. DevOps and Testing Tools
- **GitHub Actions**: Automates CI/CD workflows, deploy aws resources and test & upload front/backend code to s3 buckets
- **Terraform**: Manages AWS resources as code. All resources needed for this project is managed by terraform.
- **Cypress**: end-to-end testing of frontend react application, integrated with github actions

## Architecture

This project adopts a serverless architecture to minimize operational overhead while ensuring scalability. 

1. Serving the static website content through AWS S3 and CloudFront.
2. Using AWS Lambda to execute backend logic in response to HTTP requests via API Gateway.
3. Storing and retrieving data from AWS DynamoDB to track website interactions.
4. Employing AWS CloudWatch for monitoring and triggering updates based on predefined metrics.
5. The entire infra is managed as code using Terraform, with deployment and management processes automated through GitHub Actions.

## Repo Structure
```
│   .gitignore
│   README.md
│
├───.github
│   └───workflows
│           deploy_aws_resources.yaml
│           test&upload_to_s3.yaml
│
├───backend
│       slack_notification.py
│       visitor.py
│
├───frontend
│   │   .gitignore
│   │   cypress.config.js
│   │   data.js
│   │   index.html
│   │   index.js
│   │   package-lock.json
│   │   package.json
│   │
│   └───cypress
│       ├───e2e
│       │       e2e.spec.js
│       │
│       └───support
│               e2e.js
│
└───terraform
    │   main.tf
    │   outputs.tf
    │   provider.tf
    │   variables.tf
    │
    └───modules
        ├───management
        │       main.tf
        │       outputs.tf
        │       variables.tf
        │
        ├───network
        │       main.tf
        │       outputs.tf
        │       variables.tf
        │
        └───serveless
                main.tf
                outputs.tf
                variables.tf
```
## Output