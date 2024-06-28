# modules/local/local.tf

# Terraform configuration file to create a local file containing the name servers.

# Create a local file to store the name servers.
resource "local_file" "name_servers" {
  content  = join("\n", var.name_servers)    # Join the name servers array into a single string with each name server on a new line.
  filename = "${path.root}/name_servers.txt" # The path and filename where the content will be written.
}

