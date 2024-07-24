# Step Functions State Machine
resource "aws_sfn_state_machine" "ecs_stop_state_machine" {
  name     = "ecsStopStateMachine"
  role_arn = var.iam_role_arn_for_stepfunction

  definition = <<DEFINITION
{
  "Comment": "State machine to stop ECS task",
  "StartAt": "Wait",
  "States": {
    "Wait": {
      "Type": "Wait",
      "Seconds": 60,
      "Comment": "60s",
      "Next": "StopTask"
    },
    "StopTask": {
      "Type": "Task",
      "Resource": "arn:aws:states:::ecs:stopTask.sync",
      "Parameters": {
        "Cluster": "${var.ecs_cluster_arn}",
        "Task": "$.TaskArn"
      },
      "End": true
    }
  }
}
DEFINITION
}
