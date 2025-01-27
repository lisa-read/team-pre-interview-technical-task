data "aws_caller_identity" "current" {}

module "sns_queues" {
  source = "./modules/sns_queue"

  prefix = var.prefix
  sns_topics = {
    basket   = var.sns_basket_events
    checkout = var.sns_checkout_events
  }
}

module "queue" {
  source = "./modules/queue"
  prefix = var.prefix
  suffix = "purchase-events"
}

module "iam" {
  source        = "./modules/iam"
  prefix        = var.prefix
  event_bus     = var.event_bus
  sqs_target    = module.queue.queue_arn
  account_id    = data.aws_caller_identity.current.account_id
  region        = var.region
  source_queues = module.sns_queues.queue_arns
}


module "pipes" {
  source = "./modules/pipes"

  prefix           = var.prefix
  role_arn         = module.iam.pipe_role_arn
  source_queues    = module.sns_queues.queue_arns
  target_queue_arn = module.queue.queue_arn
}

module "eventbridge" {
  source         = "./modules/eventbridge"
  rule_name      = "${var.prefix}-sns-to-sqs-rule"
  event_bus_name = var.event_bus_name
  event_pattern = {
    source      = ["aws.sns"]
    detail-type = ["AWS API Call via CloudTrail"]
    detail = {
      eventSource = ["sns.amazonaws.com"]
      eventName   = ["Publish"]
      resources   = [var.sns_basket_events, var.sns_checkout_events]
    }
  }
  target_arn = module.queue.queue_arn
  role_arn   = module.iam.eventbridge_role_arn
}

/*
# TBD long term we would likely want some monitoring - commented out for now
module "monitoring" {
  source = "./modules/monitoring"
  
  prefix          = var.prefix
  sns_alarm_topic = var.sns_alarm_topic
  aws_region      = var.region
  queue_names = {
    dead_letter_queue = module.queue.dlq_name
    purchase_events   = module.queue.queue_name
  }
  pipe_names = module.pipes.pipe_names
  alarm_settings = {
    sqs_evaluation_periods  = 3
    sqs_period             = 300
    sqs_threshold          = 10
    pipe_evaluation_periods = 2
    pipe_period            = 300
    pipe_duration_threshold = 10000
  }
}
*/
