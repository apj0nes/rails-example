# Rails Example

Example application using the public-lambda-api and aurora-serverless modules to provision Rails API hosted in Lambda with a MySQL Aurora Serverless data store.

## Design decisions / Goals

- No clear text passwords, secret management
- Must be load balanced
- Uses a modular infrastructure for reusability
- Scalability, availability, security, simplicity, cost
- Tech agnostic and felxible to an extent, without options overload
- Documented
- All in 3-4 hours...

Due to time constraints and the amount of work required to deliver I needed to make some assumptions about the underlying infrsatructure as not to get boged down in implementing every tiny feature.
I also made the decision to focus on the infrasturcture side, the reason being, I have lots of experience developing applications using .NET and felt that the main goal was to demonstrate the arcitecture I would create rather than demonstrate my abilty to code an application. If you want this, I can easily knock up a .NET based solution to do whatever you like. (Rails will take longer as I am not experienced)
Chose to use a lambda to host but typically I would containerize the application, and provision an ec2 instance (fedora coreos would be my distribution of choice) using ignition to configure the instance. If you would like a demo of this, again I can pull something togther.

I also have not touched on the CI/CD of the application as again, I believe this to be oiutside the breif, but if you would to know more about that aspect, I can also provide examples of what I would do.

It is a bit rough around the edges, but I hope it demonstrates most of what you are looking for. If I have not demonstrated something, let me know.

## Assumptions

Typically, a number of resources would be setup once (modified infrequently) and felt the provisioning of these resources would be outside the scope of the task. Below I have explained the assumptions I have made and given an explanation of the roughly what I expect to be set up. If you would like me to elaborate on any of the below, let me know and I'm happy to provide more info.

### Secret/Credential Management
Typically, infrastructure would be provisioned using an EC2 runner with the necessary IAM Instance Profile / IAM Role attached avoiding the need for hard coded AWS credentials. The Fastly provider would also be initialised using an API key set as an environment variable on the EC2 runner again avoiding the need for hard coding credentials.
In order to get the secrets into the provisioned EC2 runner’s in the first place, typically I would have used a solution such as a Vault cluster to retrieve and set these secrets at provision time. Using this approach keeps credentials out of the consuming applications leaving developers free to focus on deploying without needing to concern themselves with the security implications of secret management.
When secrets are required (application specific), the Vault cluster can be accessed to retrieve secrets.

### VPC considerations
This module assumes a VPC has been provisioned, with subnet’s configured in each AZ. (typically there would be additional VPC’s for non-prod / test environments and multi region setups e.g. eu-west-1 and eu-central-1 in production for high availability in the unlikely event all AZ’s in a region go down). A rough overview of the subnet layout I would expect would look something like
Public (outbound NAT gateways)
LB Public (public facing load balancers)
Private (EC2/Lambda instances etc.)
LB Private (internal load balancers)
Additionally, I expect network acl’s and relevant base security groups.

### Terraform Setup
Remote state stored in an S3 bucket (typically I would retrieve vpc information from the remote state file, subnets / cidr’s / common security groups etc) 

### Resource Tagging
Resources should be tagged, useful for identifying / grouping resource for example costing reports, tacking which resources come from which teams, ec2 discovery (prometheus scraping)

### Naming Module
Generate consistent resource naming based on parameters

### Zone’s module
Exposes the route 53 zone id’s 

## Modules created and used
- https://github.com/apj0nes/public-lambda-api
- https://github.com/apj0nes/aurora-serverless.git

