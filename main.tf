locals {
  atc_script = var.shellscript ? "${path.module}/atcscript_shell.tmpl" : "${path.module}/atcscript.tmpl"
  atc_command = templatefile(local.atc_script, {
    initial_wait              = var.initial_wait,
    bigip_user                = var.bigip_user,
    bigip_password            = var.bigip_password,
    bigip_address             = var.bigip_address,
    bigip_atc_status_endpoint = var.bigip_atc_status_endpoint,
    bigip_atc_endpoint        = var.bigip_atc_endpoint,
    retry_limit               = var.retry_limit,
    poll_interval             = var.poll_interval,
    bigip_atc_payload         = var.bigip_atc_payload,
    wait_for_completion       = (var.wait_for_completion ? 1 : 0)
  })
  remote_script_location = "/var/tmp/atc_script"
}

resource "null_resource" "bigip_atc" {
  count = var.shellscript ? 0 : 1
  # this requires that the host executing Terraform
  # is able to communicate with the target BIG-IPs
  provisioner "local-exec" {
    command = local.atc_command
    interpreter = [
      "/bin/bash",
      "-c"
    ]
  }
  triggers = var.trigger_on_payload ? { declaration = base64sha256(var.bigip_atc_payload) } : {}
}

resource "null_resource" "bigip_atc_wait" {
  count = var.shellscript ? 1 : 0
  # this requires that the host executing Terraform
  # is able to communicate with the target BIG-IPs
  provisioner "local-exec" {
    command = local.atc_command
    interpreter = [
      "/bin/bash",
      "-c"
    ]
  }
  triggers = var.trigger_on_payload ? { declaration = base64sha256(var.bigip_atc_payload) } : {}
}

resource "null_resource" "bigip_atc_additional_file" {
  count = var.additional_file_destination == "" ? 0 : 1
  provisioner "file" {
    content     = var.additional_file_content
    destination = var.additional_file_destination
  }  
  connection {
    type     = "ssh"
    user     = var.bigip_user
    password = var.bigip_password
    host     = var.bigip_address
  }
  depends_on = [
    null_resource.bigip_atc_wait
  ]
}

resource "null_resource" "bigip_atc_shell" {
  count = var.shellscript ? 1 : 0
  provisioner "file" {
    destination = local.remote_script_location
    content     = var.bigip_atc_payload
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x ${local.remote_script_location}",
      local.remote_script_location,
      "rm ${local.remote_script_location}"
    ]
  }
  connection {
    type     = "ssh"
    user     = var.bigip_user
    password = var.bigip_password
    host     = var.bigip_address
  }
  depends_on = [
    null_resource.bigip_atc_wait, null_resource.bigip_atc_additional_file
  ]
}