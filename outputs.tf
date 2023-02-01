# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance_id" {
  value = aws_instance.example.id
}
