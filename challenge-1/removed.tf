moved {
  from = aws_s3_object.object["bucket-1"]
  to   = aws_s3_object.object_bucket_1
}

removed {
  from = aws_s3_object.object_bucket_1
  lifecycle {
    destroy = false
  }
}
moved {
  from = aws_s3_object.object["bucket-2"]
  to   = aws_s3_object.object_bucket_2
}

removed {
  from = aws_s3_object.object_bucket_2
  lifecycle {
    destroy = false
  }
}
