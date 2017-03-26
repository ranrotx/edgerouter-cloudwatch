import boto3
import os


cw = boto3.client('cloudwatch')
hostname = os.uname()[1]

response = cw.put_metric_data(
	Namespace='Edgerouter',
	MetricData=[
		{
			'MetricName': 'IS_UP',
			'Dimensions': [
				{
					'Name': 'Hostname',
					'Value': hostname
				},
			],
			'Value': 1
		}
	]
)
