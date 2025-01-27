variable "prefix" {
  description = "Prefix to be used for all resource names"
  type        = string
  default     = "forest-access"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "sns_basket_events" {
  type    = string
  default = "arn:aws:sns:eu-west-1:536697261635:forest-access-basket-events"
}

variable "sns_checkout_events" {
  type    = string
  default = "arn:aws:sns:eu-west-1:536697261635:forest-access-checkout-events"
}

variable "event_bus" {
  type    = string
  default = "arn:aws:events:eu-west-1:536697261635:event-bus/forest-access-domain-events"
}

variable "event_bus_name" {
  type    = string
  default = "forest-access-domain-events"
}

variable "user" {
  type    = string
  default = "arn:aws:iam::536697261635:user/forest-access"
}

/*
# Commenting out as we do not have alarm topic maybe TBD item
variable "sns_alarm_topic" {
  type    = string
  default = "arn:aws:sns:eu-west-1:536697261635:alarm-topic"
}
*/
