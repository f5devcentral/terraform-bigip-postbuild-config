module bigip {
  count               = var.instance_count
  source              = "git::git@github.com:F5Networks/terraform-gcp-bigip-module.git?ref=v1.0.0"
  prefix              = format("%s-3nic", var.prefix)
  project_id          = var.project_id
  zone                = var.zone
  image               = var.image
  disk_size_gb        = 60
  service_account     = var.service_account
  mgmt_subnet_ids     = [{ "subnet_id" = google_compute_subnetwork.mgmt_subnetwork.id, "public_ip" = true, "private_ip_primary" = "" }]
  external_subnet_ids = [{ "subnet_id" = google_compute_subnetwork.external_subnetwork.id, "public_ip" = true, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  internal_subnet_ids = [{ "subnet_id" = google_compute_subnetwork.internal_subnetwork.id, "public_ip" = false, "private_ip_primary" = "", "private_ip_secondary" = "" }]
  DO_URL              = "https://github.com/F5Networks/f5-declarative-onboarding/releases/download/v1.25.0/f5-declarative-onboarding-1.25.0-7.noarch.rpm"
  custom_user_data    = null
}