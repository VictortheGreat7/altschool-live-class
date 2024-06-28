# modules/local/variables.tf

variable "name_servers" {
    description = "List of name servers"
    type    = list(string)
}