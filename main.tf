# Copyright (C) SecretStartups <hello@secretstartups.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# you may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# SPDX-License-Identifier: Apache-2.0

locals {
}

resource "digitalocean_kubernetes_cluster" "this" {
  name                             = var.name
  region                           = var.region
  version                          = data.digitalocean_kubernetes_versions.this.latest_version
  tags                             = var.tags
  auto_upgrade                     = var.auto_upgrade
  destroy_all_associated_resources = var.destroy_all_associated_resources
  surge_upgrade                    = var.surge_upgrade
  ha                               = var.ha
  registry_integration             = var.registry_integration

  # Network-related Config
  vpc_uuid       = digitalocean_vpc.this.id
  cluster_subnet = var.cluster_subnet
  service_subnet = var.service_subnet

  node_pool {
    name       = format("%s-%s", var.name, var.node_suffix)
    size       = var.instance_type
    auto_scale = var.auto_scale
    min_nodes  = var.min_nodes
    max_nodes  = var.max_nodes
    tags       = var.node_tags
    labels     = var.node_labels
  }

  maintenance_policy {
    start_time = var.maintenance_policy_start_time
    day        = var.maintenance_policy_day
  }

  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags, node_pool
    ]
  }
}


resource "digitalocean_vpc" "this" {
  name     = var.name
  region   = var.region
  ip_range = var.vpc_cidr

  # The DOKS cluster API returns success within ~1s, but the underlying Droplets
  # (nodes) are still being deprovisioned by DigitalOcean asynchronously. Without
  # a wait the VPC delete is rejected immediately ("resources still exist in VPC")
  # and enters a long retry loop. Sleeping here gives DO time to finish cleanup
  # before the first delete attempt, reducing total destroy time significantly.
  # time_sleep cannot be used because cluster depends on VPC, creating a cycle.
  provisioner "local-exec" {
    when    = destroy
    command = "sleep 120"
  }
}
