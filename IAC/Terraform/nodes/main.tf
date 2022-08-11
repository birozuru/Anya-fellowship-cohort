locals {
  name      = "polkadot"
  bootnodes = ["${local.name}-bootnode-1", "${local.name}-bootnode-2"]
  rpcnodes  = ["${local.name}-rpcnode-1", "${local.name}-rpcnode-2"]

  tags = {
    Terraform = "true"
  }
}