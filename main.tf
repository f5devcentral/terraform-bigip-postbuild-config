locals {
  atc_command = templatefile("${path.module}/atcscript.tmpl", {
    initial_wait = var.initial_wait,
    bigip_user = var.bigip_user,
    bigip_password = var.bigip_password,
    bigip_address = var.bigip_address,
    bigip_atc_status_endpoint = var.bigip_atc_status_endpoint,
    bigip_atc_endpoint = var.bigip_atc_endpoint,
    retry_limit = var.retry_limit,
    poll_interval = var.poll_interval,
    bigip_atc_payload = var.bigip_atc_payload,
    wait_for_completion = (var.wait_for_completion ? 1 : 0)
  })
}

resource "null_resource" "bigip_atc" {
  # this requires that the host executing Terraform
  # is able to communicate with the target BIG-IPs
  provisioner "local-exec" {
    command = local.atc_command
    interpreter = [
      "/bin/bash",
      "-c"
    ]
  }
  triggers = var.trigger_on_payload ? { declaration = var.bigip_atc_payload } : {}
}