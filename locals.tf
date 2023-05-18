locals {
     INSTANCE_IDS = concat(aws_spot_instance_request.spot.*.id , aws_instance.od.*.id)
}