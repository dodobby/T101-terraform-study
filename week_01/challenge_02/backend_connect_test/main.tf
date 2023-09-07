resource "local_file" "abc" {
  content = "123!"
  filename = "${path.module}/abc.txt"
}