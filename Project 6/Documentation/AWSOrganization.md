# AWS Organization Creation
An AWS Organization allows for policy-based management for multiple AWS accounts. When a Organization is created, you are able to create group accounts and manage policies that allow you to manage centrally the multiple accounts in the organization.

## Overview:
By the end of this guide you will be able to create your AWS Organization, Policies, Organization Unit, and Account creation within AWS Organization.

## Prerequisites:

•   Have a root AWS account.


## Guide:
### Pre-Requisites

To be able to create a AWS Organization you will need a root AWS account for the Organization. When creating a Organization the account you are in will become the root account for the AWS Organization. 

- You will also need to be sure that you are currently not in a organization with your root account otherwise you will have to leave the current organization.

To begin we login to the root.

- Then on the search bar type:
~~~
AWS Organization
~~~

- After click on it and click Create Organization

It will prompt you to invite users or create account although you will need to wait due to AWS requires to verify your organization before hand. 
- Your current limit is 1 invite for the organization. To expand this you will need to contact support center and have the option of being contacted from phone or email. (limit can be expanded u to 20 people)

Once you have invited the people that will be in the organization it is time to create the Organization Unit.
- This is basically groups that policies can attach to. Policies allows limitations to certain account so that certain people will have permissions over certain AWS functions.
	- This is good to prevent over budgeting and having people mistakenly create functions that may risk a companies budgeting.

- Simply go to Organize account and click on new organization unit.
	- You can then move accounts expect the root account into this organization units.

Create Policies in the Policy tab to create limitations or give full access to certain accounts.
- Once policies are created to attach them is to click either the account or the group and attach it on the right side bar.

Once all this is done you will need to create an account with a new email in the AWS Organization so that all members can access into this account with IAM without tampering the root account which is not the ideal method.
