resource "aws_apprunner_service" "main" {
    auto_scaling_configuration_arn = "arn:aws:apprunner:ap-northeast-1:218317313594:autoscalingconfiguration/DefaultConfiguration/1/00000000000000000000000000000001"
    service_name                   = "app_runner_lambda_Test"
    tags                           = {}
    tags_all                       = {}

    health_check_configuration {
        healthy_threshold   = 1
        interval            = 10
        path                = "/"
        protocol            = "TCP"
        timeout             = 5
        unhealthy_threshold = 5
    }

    instance_configuration {
        cpu    = "1024"
        memory = "2048"
    }

    network_configuration {
        egress_configuration {
            egress_type = "DEFAULT"
        }

        ingress_configuration {
            is_publicly_accessible = true
        }
    }

    observability_configuration {
        observability_enabled = false
    }

    source_configuration {
        auto_deployments_enabled = true

        authentication_configuration {
            connection_arn = "arn:aws:apprunner:ap-northeast-1:218317313594:connection/apprunner_test2/2aa43cb8b8ca4fe2a0e829658b5e64ae"
        }

        code_repository {
            repository_url = "https://github.com/yusa0730/app_runnner_test"

            code_configuration {
                configuration_source = "API"

                code_configuration_values {
                    build_command                 = "yarn install && yarn build"
                    port                          = "3000"
                    runtime                       = "NODEJS_12"
                    runtime_environment_secrets   = {}
                    runtime_environment_variables = {}
                    start_command                 = "yarn start"
                }
            }

            source_code_version {
                type  = "BRANCH"
                value = "main"
            }
        }
    }
}

resource "aws_apprunner_vpc_connector" "main" {
    security_groups = [
      aws_security_group.from_api_gateway_to_lambda_sg.id
    ]
    subnets = [
      aws_subnet.lambda_private_a.id,
      aws_subnet.lambda_private_c.id
    ]
    tags                   = {}
    tags_all               = {}
    vpc_connector_name     = "vpc_connector_test"
}
