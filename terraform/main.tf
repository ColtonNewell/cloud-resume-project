terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}

provider "aws" {
    region = "us-west-2"
}

resource "aws_s3_bucket_policy" "S3BucketPolicy" {
    bucket = "coltonnewellresume"
    policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Sid\":\"PublicReadGetObject\",\"Effect\":\"Allow\",\"Principal\":\"*\",\"Action\":\"s3:GetObject\",\"Resource\":\"arn:aws:s3:::coltonnewellresume/*\"}]}"
}

resource "aws_s3_bucket" "S3Bucket" {
    bucket = "coltonnewellresume"
}

resource "aws_dynamodb_table" "DynamoDBTable" {
    attribute {
        name = "pk"
        type = "N"
    }
    attribute {
        name = "sk"
        type = "N"
    }
    billing_mode = "PAY_PER_REQUEST"
    name = "visitcounttable"
    hash_key = "pk"
    range_key = "sk"
}

resource "aws_route53_zone" "Route53HostedZone" {
    name = "coltonnewellresume.com."
}

resource "aws_route53_record" "Route53RecordSet" {
    name = "coltonnewellresume.com."
    type = "A"
    alias {
        name = "d39rj6r85q13ar.cloudfront.net."
        zone_id = "Z2FDTNDATAQYW2"
        evaluate_target_health = false
    }
    zone_id = "Z03106413DJ7AF9MWX8B"
}

resource "aws_route53_record" "Route53RecordSet2" {
    name = "coltonnewellresume.com."
    type = "NS"
    ttl = 172800
    records = [
        "ns-1139.awsdns-14.org.",
        "ns-1541.awsdns-00.co.uk.",
        "ns-614.awsdns-12.net.",
        "ns-343.awsdns-42.com."
    ]
    zone_id = "Z03106413DJ7AF9MWX8B"
}

resource "aws_route53_record" "Route53RecordSet3" {
    name = "coltonnewellresume.com."
    type = "SOA"
    ttl = 900
    records = [
        "ns-1139.awsdns-14.org. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400"
    ]
    zone_id = "Z03106413DJ7AF9MWX8B"
}

resource "aws_route53_record" "Route53RecordSet4" {
    name = "_4dac8f85f2c4d1bf4580d4e174dddfd6.coltonnewellresume.com."
    type = "CNAME"
    ttl = 300
    records = [
        "_5a158f2db92acb8a1e39ea5b712abd60.kdbplsmznr.acm-validations.aws."
    ]
    zone_id = "Z03106413DJ7AF9MWX8B"
}

resource "aws_api_gateway_stage" "ApiGatewayStage" {
    stage_name = "default"
    deployment_id = "yyazt4"
    rest_api_id = "1kf9z3nut9"
    description = "Created by AWS Lambda"
    cache_cluster_enabled = false
    xray_tracing_enabled = false
}

resource "aws_api_gateway_stage" "ApiGatewayStage2" {
    stage_name = "dev"
    deployment_id = "qn3fnb"
    rest_api_id = "1kf9z3nut9"
    cache_cluster_enabled = false
    xray_tracing_enabled = false
}

resource "aws_api_gateway_rest_api" "ApiGatewayRestApi" {
    name = "visitorcountfunction-API"
    description = "Created by AWS Lambda"
    api_key_source = "HEADER"
    endpoint_configuration {
        types = [
            "REGIONAL"
        ]
    }
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment" {
    rest_api_id = "1kf9z3nut9"
    description = "Created by AWS Lambda"
}

resource "aws_api_gateway_deployment" "ApiGatewayDeployment2" {
    rest_api_id = "1kf9z3nut9"
    description = "Created by AWS Lambda"
}

resource "aws_api_gateway_resource" "ApiGatewayResource" {
    rest_api_id = "1kf9z3nut9"
    path_part = "visitorcountfunction"
    parent_id = "oq8qz7dgk2"
}

resource "aws_api_gateway_method" "ApiGatewayMethod" {
    rest_api_id = "1kf9z3nut9"
    resource_id = "5wgsg0"
    http_method = "OPTIONS"
    authorization = "NONE"
    api_key_required = false
    request_parameters = {}
}

resource "aws_api_gateway_method" "ApiGatewayMethod2" {
    rest_api_id = "1kf9z3nut9"
    resource_id = "5wgsg0"
    http_method = "ANY"
    authorization = "NONE"
    api_key_required = false
}

resource "aws_api_gateway_method" "ApiGatewayMethod3" {
    rest_api_id = "1kf9z3nut9"
    resource_id = "5wgsg0"
    http_method = "POST"
    authorization = "NONE"
    api_key_required = false
    request_parameters = {}
}

resource "aws_api_gateway_method" "ApiGatewayMethod4" {
    rest_api_id = "1kf9z3nut9"
    resource_id = "5wgsg0"
    http_method = "GET"
    authorization = "NONE"
    api_key_required = false
    request_parameters = {}
}

resource "aws_cloudfront_distribution" "CloudFrontDistribution" {
    aliases = [
        "coltonnewellresume.com"
    ]
    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_keepalive_timeout = 5
            origin_protocol_policy = "http-only"
            origin_read_timeout = 30
            origin_ssl_protocols = [
                "TLSv1.2"
            ]
        }
        domain_name = "coltonnewellresume.s3-website-us-west-2.amazonaws.com"
        origin_id = "coltonnewellresume.s3-website-us-west-2.amazonaws.com"
        
        origin_path = ""
    }
    default_cache_behavior {
        allowed_methods = ["HEAD", "GET"]
        cached_methods = [ "GET", "HEAD" ]
        compress = true
        smooth_streaming  = false
        target_origin_id = "coltonnewellresume.s3-website-us-west-2.amazonaws.com"
        viewer_protocol_policy = "redirect-to-https"
    }
    comment = ""
    price_class = "PriceClass_All"
    enabled = true
    viewer_certificate {
        acm_certificate_arn = "arn:aws:acm:us-east-1:145435464519:certificate/bb851f8b-c0f5-4807-806e-b633a6cd1f2b"
        cloudfront_default_certificate = false
        minimum_protocol_version = "TLSv1.2_2021"
        ssl_support_method = "sni-only"
    }
    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    http_version = "http2"
    is_ipv6_enabled = true
}

resource "aws_lambda_function" "LambdaFunction" {
    description = ""
    environment {
        variables = {
            TABLE_NAME = "visitcounttable"
        }
    }
    function_name = "visitorcountfunction"
    handler = "lambda_function.lambda_handler"
    architectures = [
        "x86_64"
    ]
    s3_bucket = "awslambda-us-west-2-tasks"
    s3_key = "/snapshots/145435464519/visitorcountfunction-6ab23e74-d7af-4ba8-a8f2-bc2f19e315c2"
    s3_object_version = "Fm8h6rzZ9nnLZcKEWrHvcPwY0VJQrGmM"
    memory_size = 128
    role = "${aws_iam_role.IAMRole.arn}"
    runtime = "python3.8"
    timeout = 3
    tracing_config {
        mode = "PassThrough"
    }
}

resource "aws_lambda_permission" "LambdaPermission" {
    action = "lambda:InvokeFunction"
    function_name = "${aws_lambda_function.LambdaFunction.arn}"
    principal = "apigateway.amazonaws.com"
    source_arn = "arn:aws:execute-api:us-west-2:145435464519:1kf9z3nut9/*/*/visitorcountfunction"
}

resource "aws_acm_certificate" "CertificateManagerCertificate" {
    domain_name = "coltonnewellresume.com"
    subject_alternative_names = [
        "coltonnewellresume.com"
    ]
    validation_method = "DNS"
}

resource "aws_iam_role" "IAMRole" {
    path = "/service-role/"
    name = "visitorcountfunction-role-mkyrjwmz"
    assume_role_policy = "{\"Version\":\"2012-10-17\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"},\"Action\":\"sts:AssumeRole\"}]}"
    max_session_duration = 3600
    tags = {}
}

resource "aws_iam_user" "IAMUser" {
    path = "/"
    name = "IAMcgnewell"
    tags = {}
}

resource "aws_iam_group" "IAMGroup" {
    path = "/"
    name = "admin"
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole" {
    aws_service_name = "ops.apigateway.amazonaws.com"
    description = "The Service Linked Role is used by Amazon API Gateway."
}

resource "aws_iam_service_linked_role" "IAMServiceLinkedRole2" {
    aws_service_name = "dynamodb.application-autoscaling.amazonaws.com"
}

resource "aws_iam_policy" "IAMManagedPolicy" {
    name = "AWSLambdaBasicExecutionRole-45140834-2f4c-45ed-a794-cbd12d9a1780"
    path = "/service-role/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-west-2:145435464519:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-west-2:145435464519:log-group:/aws/lambda/visitorcountfunction:*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_policy" "IAMManagedPolicy2" {
    name = "AWSLambdaBasicExecutionRole-476bb48b-47a0-454e-bea2-04c51c400c56"
    path = "/service-role/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:us-west-2:145435464519:*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:us-west-2:145435464519:log-group:/aws/lambda/HelloWorldFunction:*"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "IAMPolicy" {
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "dynamodb:ListContributorInsights",
                "dynamodb:DescribeReservedCapacityOfferings",
                "dynamodb:ListGlobalTables",
                "dynamodb:ListTables",
                "dynamodb:DescribeReservedCapacity",
                "dynamodb:ListBackups",
                "dynamodb:PurchaseReservedCapacityOfferings",
                "dynamodb:ListImports",
                "dynamodb:DescribeLimits",
                "dynamodb:DescribeEndpoints",
                "dynamodb:ListExports",
                "dynamodb:ListStreams"
            ],
            "Resource": "*"
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": "arn:aws:dynamodb:*:145435464519:table/*"
        },
        {
            "Sid": "VisualEditor2",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": [
                "arn:aws:dynamodb:*:145435464519:table/*/import/*",
                "arn:aws:dynamodb:*:145435464519:table/*/backup/*",
                "arn:aws:dynamodb:*:145435464519:table/*/stream/*",
                "arn:aws:dynamodb:*:145435464519:table/*/export/*",
                "arn:aws:dynamodb:*:145435464519:table/*/index/*",
                "arn:aws:dynamodb::145435464519:global-table/*"
            ]
        }
    ]
}
EOF
    role = "${aws_iam_role.IAMRole.name}"
}
