# Define required providers
terraform {
  required_version = ">= 0.14.0"
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.1"
    }
    time = {
      source = "hashicorp/time"
      version = "0.9.1"
    }
    openstack = {
      source = "terraform-provider-openstack/openstack"
      version = "1.52.1"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name   = "admin"
  tenant_name = "admin"
  password    = "<Password>"
  auth_url    = "http://<Server IP>:5000"
  region      = "RegionOne"
}
