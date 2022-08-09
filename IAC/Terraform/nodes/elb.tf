#############################################
# LOADBALANCER
#############################################

resource "aws_elb" "rpcnode" {
  name = "rpc-elb"

  subnets = ["${aws_subnet.node.id}"]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  listener {
    instance_port     = 30333
    instance_protocol = "tcp"
    lb_port           = 30333
    lb_protocol       = "tcp"
  }
  listener {
    instance_port     = 30334
    instance_protocol = "tcp"
    lb_port           = 30334
    lb_protocol       = "tcp"
  }
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

}

resource "aws_elb_attachment" "rpcnode" {
  for_each = module.rpcnode
  elb      = aws_elb.rpcnode.id
  instance = module.rpcnode[each.key].id
}