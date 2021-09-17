module bigip {
  count               = var.instance_count
  source              = "git::git@github.com:f5devcentral/terraform-gcp-bigip-module.git?ref=v0.9.3"
  prefix              = format("%s-3nic", var.prefix)
  project_id          = var.project_id
  zone                = var.zone
  image               = var.image
  disk_size_gb        = 60
  service_account     = var.service_account
  mgmt_subnet_ids     = [{ "subnet_id" = google_compute_subnetwork.mgmt_subnetwork.id, "public_ip" = true, "private_ip_primary" = "" }]
  external_subnet_ids = [{ "subnet_id" = google_compute_subnetwork.external_subnetwork.id, "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  internal_subnet_ids = [{ "subnet_id" = google_compute_subnetwork.internal_subnetwork.id, "public_ip" = false, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  DO_URL              = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.22.0/f5-declarative-onboarding-1.22.0-3.noarch.rpm"
  custom_user_data = ""
}