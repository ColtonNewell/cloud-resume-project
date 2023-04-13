import json
import boto3
import os

dynamodb = boto3.resource("dynamodb")
table_name = os.environ["TABLE_NAME"]
table = dynamodb.Table(table_name)


def lambda_handler(event, context):
    response = table.get_item(Key={"pk": 1, "sk": 1})
    
    record_count = response['Item']['record_count']
    record_count += 1
    print(record_count)
    
    response = table.put_item(Item={'pk': 1, 'sk': 1, 'record_count': record_count})
    
    return {
    "statusCode": 200,
    "headers": { "content-type": "application/json", "access-control-allow-origin": "*" },
    "body": json.dumps({ "count": str(record_count) })
}
