import boto3
import os

def lambda_handler(event, context):
    ecs = boto3.client('ecs')

    cluster_arn = os.environ['CLUSTER_ARN']
    cluster_name = os.environ['CLUSTER_NAME']
    task_definition_arn = os.environ['TASK_ARN']

    try:
        # ECSタスクの一覧を取得
        response = ecs.list_tasks(cluster=cluster_name, taskDefinition=task_definition_arn)
        task_arns = response['taskArns']

        # タスクを停止
        for task_arn in task_arns:
            ecs.stop_task(
                cluster=cluster_arn,
                task=task_arn,
                reason='Stopped by Lambda function after 10 seconds'
            )

        return {
            'statusCode': 200,
            'body': {
                'message': 'Tasks stopped successfully',
                'task_arns': task_arns
            }
        }

    except Exception as e:
        return {
            'statusCode': 500,
            'body': {
                'message': str(e)
            }
        }
