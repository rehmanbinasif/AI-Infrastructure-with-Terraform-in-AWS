resource "aws_sqs_queue" "SQSQueue" {
    delay_seconds = "10"
    max_message_size = "262144"
    message_retention_seconds = "345600"
    receive_wait_time_seconds = "10"
    visibility_timeout_seconds = "43200"
    name = "daisy-messages"
}

resource "aws_sqs_queue" "SQSQueue2" {
    delay_seconds = "0"
    max_message_size = "262144"
    message_retention_seconds = "345600"
    receive_wait_time_seconds = "0"
    visibility_timeout_seconds = "30"
    name = "daisy-xray-messages"
}

resource "aws_sqs_queue_policy" "SQSQueuePolicy" {
    policy = "{\"Version\":\"2012-10-17\",\"Id\":\"AnyUserSendMessage\",\"Statement\":[{\"Effect\":\"Allow\",\"Principal\":{\"AWS\":\"*\"},\"Action\":\"sqs:*\",\"Resource\":\"${aws_sqs_queue.SQSQueue.arn}\"}]}"
    queue_url = "${aws_sqs_queue.SQSQueue.url}"
}

resource "aws_sqs_queue_policy" "SQSQueuePolicy2" {
    policy = "{\"Version\":\"2012-10-17\",\"Id\":\"__default_policy_ID\",\"Statement\":[{\"Sid\":\"__owner_statement\",\"Effect\":\"Allow\",\"Action\":\"SQS:*\",\"Resource\":\"${aws_sqs_queue.SQSQueue2.arn}\"}]}"
    queue_url = "${aws_sqs_queue.SQSQueue2.url}"
}
