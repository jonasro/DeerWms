variable "resource_group_location" {
  type        = string
  default     = "northeurope"
  description = "Location of the resource group."
}

variable "node_count" {
  type        = number
  description = "The initial quantity of nodes for the node pool"
  default     = 2
}

variable "aks_username" {
  type        = string
  description = "The admin username for the cluster"
  default     = "azureadmin"
}