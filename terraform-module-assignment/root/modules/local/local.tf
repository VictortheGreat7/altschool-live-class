# modules/local/local.tf

resource "local_file" "name_servers" {
  content  = join("\n", var.name_servers)
  filename = "${path.root}/name_servers.txt"
}
