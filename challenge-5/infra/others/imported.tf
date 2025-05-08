import {
  to = module.ec2.aws_instance.ec2["subnet-01c968ae6877dd879"]
  id = "i-093b3126396f78915"
}
import {
  to = module.ec2.aws_instance.ec2["subnet-024e5e1e3bd393e8b"]
  id = "i-07040003d75595626"
}
import {
  to = module.sg.aws_security_group.sg["app-1-sg"]
  id = "sg-034c74b215599a2b8"
}
import {
  to = module.sg.aws_security_group.sg["app-2-sg"]
  id = "sg-0fc43c338f57b3ab7"
}

import {
  to = module.sg.aws_vpc_security_group_egress_rule.app_1_sg["sg02-8443-out"]
  id = "sgr-092eab724980b7a4e"
}
import {
  to = module.sg.aws_vpc_security_group_egress_rule.app_1_sg["sg02-9000-out"]
  id = "sgr-0f444cceca47b1c5d"
}
import {
  to = module.sg.aws_vpc_security_group_ingress_rule.app_1_sg["sg01-443-in"]
  id = "sgr-04d0e543c9ce2dfa9"
}
import {
  to = module.sg.aws_vpc_security_group_ingress_rule.app_1_sg["sg01-80-in"]
  id = "sgr-09ccfd050682c5531"
}

