## Setting up a Lambda Function with AWS Lambda and AWS CloudWatch
1. Login to the AWS Console.
2. Go to Lambda under Services > Compute > Lambda.
3. Click on Create Function.
4. Give the function a name, then select Python 2.7
5. Select Create Custom Role from Role > Select Custom Role
6. Select Create a new IAM Role from the IAM Role dropdown.
7. Expand the Policy Document then click Edit.
8. Replace the given Policy Document with the following then click Allow.
```
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource": "arn:aws:logs:*:*:*"
      },
      {
        "Effect": "Allow",
        "Action": [
          "ec2:Start*",
          "ec2:Stop*"
        ],
        "Resource": "*"
      }
    ]
  }
```

9. Go to Role > Choose an existing role then under Existing role select the role created in step 8, then click Create function.
10. Scroll down to Function code then replace the given code with the following for shutting down the instances:
```
  import boto3
  # Enter the region your instances are in. Include only the region without specifying Availability Zone; e.g., 'us-east-1'
  region = 'XX-XXXXX-X'
  # Enter your instances here: ex. ['X-XXXXXXXX', 'X-XXXXXXXX']
  instances = ['X-XXXXXXXX']

  def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    ec2.stop_instances(InstanceIds=instances)
    print 'stopped your instances: ' + str(instances)
```

11. Use the following code for starting up the instances:
```
  import boto3
  # Enter the region your instances are in. Include only the region without specifying Availability Zone; e.g.; 'us-east-1'
  region = 'XX-XXXXX-X'
  # Enter your instances here: ex. ['X-XXXXXXXX', 'X-XXXXXXXX']
  instances = ['X-XXXXXXXX']

  def lambda_handler(event, context):
    ec2 = boto3.client('ec2', region_name=region)
    ec2.start_instances(InstanceIds=instances)
    print 'started your instances: ' + str(instances)
```

12. Under Basic settings, set the Timeout to 10 seconds and click Save.
13. Go to Services > Management & Governance > CloudWatch > Events > Rules.
14. Click Create rule > Schedule > Cron expression > ```0 16 ? * MON-FRI *``` for starting up instances and ```55 7 ? * MON-FRI *``` for shutting down instances.
15. Click Add target, select the Lambda function, then click Configure details.
16. Give a name and description to the new rule then click Create rule.
