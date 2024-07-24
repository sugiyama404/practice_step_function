import boto3

def lambda_handler(event, context):
    ecs = boto3.client('ecs')

    cluster = event['detail']['clusterArn']
    task = event['detail']['taskArn']

    response = ecs.stop_task(
        cluster=cluster,
        task=task,
        reason='Stopped by Lambda function after 30 minutes'
    )

    return response
