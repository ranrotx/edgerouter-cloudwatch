# edgerouter-cloudwatch
Python script for monitoring Ubiquiti Edgerouter Lite and publishing metrics to AWS CloudWatch

This is a first minimum viable product. At this point, all it does is take the current hostname and post a metric of IS_UP=1 to the Edgerouter custom namespace on your AWS account. The idea is to take this metric and set a
CloudWatch alarm for whenever the metric goes into INSUFFICENT_DATA to detect when your Edgerouter is down.

Note that it has only been testing locally--I have not loaded it onto the Edgerouter yet.

## TODO

- Add inputs:
  - Custom/Override the namespace
- More metrics
  - Memory
  - CPU
- More robust logging
- CloudFormation template to set up the CloudWatch alarm
- Package to automate deployment to the Edgerouter
