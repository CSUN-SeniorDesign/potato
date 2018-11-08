## Tasks for CIT 480

#### Irrigation Hardware Group Requirements
1. Hosting a web application

#### Irrigation Software Group Requirements
1. Two databases:
  - The first manages login information.
  - The second manages sprinkler, authorization, and timing.

2. Hosting a website that will act as a dashboard for field technicians.

4. Cost Analysis:
  - Is it better to pay a higher cost to have all amazon products being used for better integration?
  - Is it better to pay a lower cost by using different programs?

#### Encryption Group Requirements
1. Multiple S3 buckets located across the US. (At the minimum 1 in west coast, 1 in central, and 1 in east coast)

2. Two testing environments:
  - The first should be an environment that can be deleted and reinstalled. (Terraform/Dockerfile)
  - The second should retain all information for longer testing purposes. (EC2 Instance preferable)

3. A database to store all login information.

4. CircleCI for building a new Docker container based on the things they push to GitHub.

5. Cost Analysis:
  - Is it better to pay a higher cost to have all amazon products being used for better integration?
  - Is it better to pay a lower cost by using different programs?


#### For later:
  - Look into additional lowering of cost and resource usage.
  - Look into high availability options using Cloudflare/Cloudfront/CDN (Content Delivery Network)
  - Look into security
  - Look into optimizations to the system design

### To Do
##### Week of 11-5-18 to 11-12-18
  - [Documentation] [GitHub] A design document for all the services that we need to set up for each group.
  - [AWS] Create IAM roles for each project member in both Irrigation and Encryption groups.
  - [Research] [Irrigation] [Encryption] Find the cheapest database service on AWS
  - [Research] [Irrigation] Find the cheapest web hosting on AWS
    - [Research] [Irrigation] [Encryption] Find the cheapest way to host an ec2 instance or docker container for testing purposes.
  - [Research] [Encryption] Find the cheapest S3 bucket usage for the Encryption group.
  - [Documentation] [GitHub] Create documentation for the completed research.
  - [Practice] Testing Dockerfile configurations for different requirements.
  - [Practice] Hosting Docker containers based on tested Dockerfiles for reliability.
  - [Documentation] [GitHub] Create documentation for the completed practice.

##### Week of 11-19-18 to 11-26-18
  - [Practice] Creating EC2 instances using Terraform.
  - [Practice] Creating scripts to install required programs using Ansible or Packer.
  - [Documentation] [GitHub] Create documentation for the completed practice.
  - [Irrigation] Create a Dockerfile to show the irrigation software group.
    - [Irrigation] Tweak the Dockerfile based on the feedback given by the Irrigation software group.
  - [Encryption] Create a Dockerfile to show the Encryption group.
    - [Encryption] Tweak the Dockerfile based on the feedback given by the Encryption group.
  - [Documentation] [GitHub] Create documenation for Dockerfiles.

### Completed
##### Week of 11-5-18 to 11-12-18
  - [GitHub] Join the new GitHub group
  - [AWS] Join the new AWS organization
