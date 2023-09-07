# 도전과제3 :  lifecycle의 precondition

variable "file_number" {
  default = "0" # 수정 (6으로 변경시 에러 X)
}

locals {
  file_name = "step${var.file_number}.txt"
}

resource "local_file" "abc" {
  content  = "lifecycle - step ${var.file_number}"
  filename = "${path.module}/${local.file_name}"

  lifecycle {
    precondition {
      condition     = local.file_name == "step6.txt"
      error_message = "file name is not \"step6.txt\""
    }
  }
}