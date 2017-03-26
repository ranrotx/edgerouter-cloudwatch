# edgerouter-cloudwatch
Python script for monitoring Ubiquiti Edgerouter Lite and publishing metrics to AWS CloudWatch

This is a first minimum viable product. At this point, all it does is take the current hostname and post a metric of IS_UP=1 to the Edgerouter custom namespace on your AWS account. The idea is to take this metric and set a
CloudWatch alarm for whenever the metric goes into INSUFFICENT_DATA to detect when your Edgerouter is down.

## To install

1. Copy [erl-put-cloudwatch-metrics.py](erl-put-cloudwatch-metrics.py) to the ```/config/scripts``` directory on your Edgerouter. This directory is not deleted on system upgrades.
2. Create an ```aws-credentails``` file in your ```/config/scripts``` directory with the following. The IAM user will need access to put the metrics to CloudWatch (see sample policy below).

    ```
    [default]
    aws_access_key_id=
    aws_secret_access_key=
    ```
3. Copy the [setup-cloudwatch.sh](setup-cloudwatch.sh) file to your ```/config/sctipts/post-config.d``` folder and make it executable. Run the script to install the dependencies and symlink your credentials. This file (and any executables in the same directory) are run after each system upgrade.
4. Create a scheduled task to run the Python script every minute (or change to your desire):

    ```
    set system task-scheduler task cloudwatch executable path /usr/bin/python
    set system task-scheduler task cloudwatch executable arguments /config/scripts/erl-put-cloudwatch-metrics.py
    set system task-scheduler task cloudwatch interval 1m
    commit
    save
    ```

The scheduled task should start to run. You can go to your CloudWatch console and watch the metrics appear. From here, you can set an alarm to notify you whenever the data point goes below 1 for a period of time.

## Sample IAM policy

The below policy can be used to create a user that only has access to publish metrics to CloudWatch.

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "Stmt1490476022000",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

## TODO

- Add inputs:
  - Custom/Override the namespace
  - AWS region
- More metrics
  - Memory
  - CPU
- More robust logging
- CloudFormation template to set up the CloudWatch alarm
- Package to automate deployment to the Edgerouter
