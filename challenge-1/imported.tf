import {
  to = aws_iam_user.lb[0]
  id = "welcomed-ferret-my-org-0"
}
import {
  to = aws_iam_user.lb[1]
  id = "welcomed-ferret-my-org-1"
}
import {
  to = aws_iam_user.lb[2]
  id = "welcomed-ferret-my-org-2"
}

# import {
#   to = random_pet.this
#   id = "welcomed-ferret"
# }

import {
  to = aws_iam_user_policy.lb_ro["0"]
  id = "welcomed-ferret-my-org-0:ec2-describe-policy"
}
import {
  to = aws_iam_user_policy.lb_ro["1"]
  id = "welcomed-ferret-my-org-1:ec2-describe-policy"
}
import {
  to = aws_iam_user_policy.lb_ro["2"]
  id = "welcomed-ferret-my-org-2:ec2-describe-policy"
}
import {
  to = aws_s3_bucket.example["bucket-1"]
  id = "welcomed-ferret-bucket-1"
}
import {
  to = aws_s3_bucket.example["bucket-2"]
  id = "welcomed-ferret-bucket-2"
}
# import {
#   to = aws_s3_object.object["bucket-1"]
#   id = "welcomed-ferret-bucket-1/myobject"
# }
# import {
#   to = aws_s3_object.object["bucket-2"]
#   id = "welcomed-ferret-bucket-2/myobject"
# }
