# Copyright (C) SecretStartups <hello@secretstartups.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
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

# Please see https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/kubernetes_cluster

output "cluster_id" {
  description = "The ID of the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.this.id
}

output "cluster_name" {
  description = "The name of the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.this.name
}

output "cluster_region" {
  description = "The region where the Kubernetes cluster is located."
  value       = digitalocean_kubernetes_cluster.this.region
}

output "cluster_version" {
  description = "The version of Kubernetes running on the cluster."
  value       = digitalocean_kubernetes_cluster.this.version
}

output "cluster_status" {
  description = "The current status of the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.this.status
}

output "cluster_endpoint" {
  description = "The endpoint for accessing the Kubernetes cluster."
  value       = digitalocean_kubernetes_cluster.this.endpoint
}

output "cluster_node_pool_ids" {
  description = "The IDs of the node pools in the Kubernetes cluster."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.id]
}

output "cluster_node_pool_names" {
  description = "The names of the node pools in the Kubernetes cluster."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.name]
}

output "cluster_node_pool_sizes" {
  description = "The sizes of the nodes in the node pools."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.size]
}

output "cluster_node_pool_auto_scale" {
  description = "Whether auto-scaling is enabled for the node pools."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.auto_scale]
}

output "cluster_node_pool_min_nodes" {
  description = "The minimum number of nodes in the node pools."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.min_nodes]
}

output "cluster_node_pool_max_nodes" {
  description = "The maximum number of nodes in the node pools."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.max_nodes]
}

output "cluster_node_pool_node_count" {
  description = "The number of nodes in the node pools."
  value       = [for np in digitalocean_kubernetes_cluster.this.node_pool : np.node_count]
}

output "cluster_maintenance_policy" {
  description = "The maintenance policy of the Kubernetes cluster."
  value = {
    start_time = digitalocean_kubernetes_cluster.this.maintenance_policy[0].start_time
    day        = digitalocean_kubernetes_cluster.this.maintenance_policy[0].day
  }
}

output "cluster_auto_upgrade" {
  value = digitalocean_kubernetes_cluster.this.auto_upgrade
}

output "cluster_kc_raw_config" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].raw_config
  sensitive = true
}

output "cluster_kc_host" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].host
  sensitive = true
}

output "cluster_kc_cluster_ca_certificate" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].cluster_ca_certificate
  sensitive = true
}

output "cluster_kc_token" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].token
  sensitive = true
}

output "cluster_kc_client_key" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].client_key
  sensitive = true
}

output "cluster_kc_client_certificate" {
  value     = digitalocean_kubernetes_cluster.this.kube_config[0].client_certificate
  sensitive = true
}
