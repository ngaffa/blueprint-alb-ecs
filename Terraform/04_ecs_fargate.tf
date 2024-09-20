# ECS Cluster setup
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = var.ecs_cluster_name
}

# ECS Task Definition setup
resource "aws_ecs_task_definition" "my_task_def" {
  family                   = var.task_family_name
  execution_role_arn      = var.execution_role_arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = aws_ecr_repository.my_ecr_repo.repository_url
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.host_port
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# ECS Service setup
resource "aws_ecs_service" "my_service" {
  name            = var.service_name
  cluster         = aws_ecs_cluster.my_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_task_def.arn
  desired_count   = 2
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = [aws_subnet.private_subnets[0].id, aws_subnet.private_subnets[1].id]
    security_groups = [aws_security_group.private_sg_1.id, aws_security_group.private_sg_2.id]
  }

  depends_on = [
    aws_lb_listener.my_listener
  ]
}
