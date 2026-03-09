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

variable "do_token" {
  description = "DigitalOcean API token used to authenticate with the provider."
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "The name of the Kubernetes cluster."
  type        = string
  default     = "my-cluster"
}

# This corresponds to the version, rather than the slug produced by: `doctl kubernetes options versions`
variable "kubernetes_version" {
  description = "Kubernetes version to deploy. Defaults to latest if unspecified."
  type        = string
  default     = ""
}

# This corresponds to one of the region slugs output by: `doctl kubernetes options regions`
variable "region" {
  description = "The region where the Kubernetes cluster will be created."
  type        = string
  default     = "nyc1"
}

variable "tags" {
  description = "A list of tags to apply to the Kubernetes cluster."
  type        = list(string)
  default     = ["k8s", "production"]
}

variable "auto_upgrade" {
  description = "Whether to enable automatic upgrades for the Kubernetes cluster."
  type        = bool
  default     = true
}

variable "destroy_all_associated_resources" {
  description = "Whether to destroy all associated resources when the cluster is destroyed."
  type        = bool
  default     = false
}

variable "surge_upgrade" {
  description = "Whether to enable surge upgrades for the Kubernetes cluster."
  type        = bool
  default     = true
}

variable "ha" {
  description = "Whether to enable high availability for the Kubernetes cluster. Recommended for production workloads."
  type        = bool
  default     = false
}

variable "registry_integration" {
  description = "Whether to enable registry integration for the Kubernetes cluster."
  type        = bool
  default     = false
}

variable "vpc_uuid" {
  description = "The UUID of the VPC where the Kubernetes cluster will be created."
  type        = string
  default     = ""
}

variable "cluster_subnet" {
  description = "The subnet to be used for the Kubernetes cluster."
  type        = string
  default     = "10.251.0.0/16"
}

variable "service_subnet" {
  description = "The subnet to be used for the Kubernetes services."
  type        = string
  default     = "10.252.0.0/19"
}

variable "node_suffix" {
  description = "The suffix to be added to the node pool name."
  type        = string
  default     = "pool"
}

variable "node_count" {
  description = "The number of nodes in the node pool."
  type        = number
  default     = 3
}

variable "auto_scale" {
  description = "Whether to enable auto-scaling for the node pool."
  type        = bool
  default     = true
}

variable "min_nodes" {
  description = "The minimum number of nodes in the node pool."
  type        = number
  default     = 1
}

variable "max_nodes" {
  description = "The maximum number of nodes in the node pool."
  type        = number
  default     = 5
}

variable "node_labels" {
  description = "A map of labels to apply to the nodes in the node pool."
  type        = map(string)
  default     = {}
}

variable "maintenance_policy_start_time" {
  description = "The start time for the maintenance policy."
  type        = string
  default     = "03:00"
}

variable "maintenance_policy_day" {
  description = "The day for the maintenance policy."
  type        = string
  default     = "saturday"
}

variable "node_tags" {
  description = "A list of tags to apply to the nodes in the node pool."
  type        = list(string)
  default     = ["k8s-node"]
}

# This corresponds to the size slug output by: `doctl kubernetes options sizes`
variable "do_sizes" {
  description = "A list of maps containing the key and values for filtering DigitalOcean sizes."
  type        = any
  default = [
    {
      key    = "slug"
      values = ["s-2vcpu-4gb"]
    },
  ]
}