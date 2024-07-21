import boto3
import os
import json
import base64
import gzip

sns_client = boto3.client('sns')
sns_topic_arn = os.environ['SNS_TOPIC_ARN']

def lambda_handler(event, context):
    # CloudWatch LogsのデータはBase64でエンコードされています
    log_data_b64 = event['awslogs']['data']
    log_data = base64.b64decode(log_data_b64)

    log_data_decoded = gzip.decompress(log_data)
    log_data_decoded = json.loads(log_data_decoded)
    print(log_data_decoded)
    logEvents = log_data_decoded['logEvents']

    log_messages = []
    for index, event in enumerate(logEvents):
        log_messages.append(f"[error message {index + 1}]")
        log_messages.append(event['message'])

    # 文字列のリストを改行で結合します
    message = f"Error log detected:\n" + "\n".join(log_messages)
    subject = "CloudWatch Error Log Alert"

    # SNSトピックにメッセージをパブリッシュします
    sns_client.publish(
        TopicArn=sns_topic_arn,
        Message=message,
        Subject=subject
    )
    return {
        'statusCode': 200,
        'body': json.dumps('Email sent successfully!')
    }
