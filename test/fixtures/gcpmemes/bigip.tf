module "bigip" {
  source                           = "memes/f5-bigip/google"
  version                          = "2.1.0"
  project_id                       = var.project_id
  zones                            = [var.zone]
  service_account                  = var.service_account
  external_subnetwork              = google_compute_subnetwork.external_subnetwork.self_link
  provision_external_public_ip     = true
  external_subnetwork_public_ips   = [google_compute_address.ext_public.address]
  management_subnetwork            = google_compute_subnetwork.mgmt_subnetwork.self_link
  provision_management_public_ip   = true
  management_subnetwork_public_ips = [google_compute_address.mgt_public.address]
  # BIG-IP template accepts 1-6 NICs for internal network, just pass in a list
  # of self-links
  internal_subnetworks              = [google_compute_subnetwork.internal_subnetwork.self_link]
  provision_internal_public_ip      = true
  internal_subnetwork_public_ips    = [[google_compute_address.int_public.address]]
  image                             = var.image
  allow_phone_home                  = false
  admin_password_secret_manager_key = var.admin_password_key
}

# Reserve public IP on external subnet for BIG-IP nic0
resource "google_compute_address" "ext_public" {
  project      = var.project_id
  name         = "bigip-ext-public"
  region       = replace(var.zone, "/-[a-z]$/", "")
  address_type = "EXTERNAL"
}

# Reserve public IP on management subnet for BIG-IP nic1
resource "google_compute_address" "mgt_public" {
  project      = var.project_id
  name         = "bigip-mgt-public"
  region       = replace(var.zone, "/-[a-z]$/", "")
  address_type = "EXTERNAL"
}

# Reserve public IP on internal subnet for BIG-IP nic2
resource "google_compute_address" "int_public" {
  project      = var.project_id
  name         = "bigip-int-public"
  region       = replace(var.zone, "/-[a-z]$/", "")
  address_type = "EXTERNAL"
}
