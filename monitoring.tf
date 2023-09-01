# see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting
resource "azurerm_monitor_autoscale_setting" "main" {
  name                = var.autoscaling_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  target_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
  enabled            = var.autoscaling_enabled

  # see https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
  dynamic "profile" {
    for_each = var.autoscaling_profiles

    content {
      name = profile.value.name

      # see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#capacity
      capacity {
        default = profile.value.capacity.default
        minimum = profile.value.capacity.minimum
        maximum = profile.value.capacity.maximum
      }

      # see https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks
      dynamic "rule" {
        for_each = var.autoscaling_rules

        content {
          # see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#metric_trigger
          metric_trigger {
            metric_name        = rule.value.name
            metric_namespace   = "microsoft.compute/virtualmachinescalesets"
            metric_resource_id = azurerm_linux_virtual_machine_scale_set.main.id
            operator           = rule.value.operator
            statistic          = rule.value.statistic
            time_aggregation   = rule.value.time_aggregation
            time_grain         = rule.value.time_grain
            time_window        = rule.value.time_window
            threshold          = rule.value.threshold
          }

          # see https://registry.terraform.io/providers/hashicorp/Azurerm/latest/docs/resources/monitor_autoscale_setting#scale_action
          scale_action {
            cooldown  = rule.value.scale_action.cooldown
            direction = rule.value.scale_action.direction
            type      = rule.value.scale_action.type
            value     = rule.value.scale_action.value
          }
        }
      }
    }
  }

  tags = var.tags
}
