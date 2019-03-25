Setup IAM Terraform

	Overview:
		By the end of this tutorial the reader should be to able to setup following in AWS using just Terraform:
		
			- Create a terraform automation to create aws iam users
	
	Prerequisites:
		Computer with Windows Operating System
		AWS account
    		Create one as a student for $100 free credit: https://www.awseducate.com/registration#APP_TYPE

	Steps:
		1.  Create a tf extension file with any name that you are able to identify as the iam user

				
		2. Create group administrators in the tf file. 

				resource "aws_iam_group" "potatoadmin" {
					name = "potatoadmin"
				}
				
		3. Create the iam policy so that the users have admin access.
		
					resource "aws_iam_policy_attachment" "potatoadmin-attach" {
						name = "potatoadmin-attach"
						groups = ["${aws_iam_group.potatoadmin.name}"]
						policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
					}
				
		4. In this part the users will be created this is part of our script that created a user for each individual.
				
					resource "aws_iam_user" "adminusr1" {
						name = "DanielH1"
					}
					resource "aws_iam_user" "adminusr2" {
						name = "ShahidK1"
					}
					resource "aws_iam_user" "adminusr3" {
						name = "TonnyW1"
					}
		5. Final step if it is required we can add the users into a group.
		
				resource "aws_iam_group_membership" "potatoadmin-users" {
					name = "potatoadmin-users"
					users = [
						"${aws_iam_user.adminusr1.name}",
						"${aws_iam_user.adminusr2.name}",
						"${aws_iam_user.adminusr3.name}",

					]
					group = "${aws_iam_group.potatoadmin.name}"
				}