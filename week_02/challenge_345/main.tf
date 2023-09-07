//도전과제 3 : 입력 변수 사용
# Volume Type 설정을 위한 변수
variable "default_vol_type" {
  type = string
  default = "_DEFAULT_"
}
# volume 생성을 위한 변수
variable "instance_volume_info" {
  description = "VM Volume 정보"
  type        = map(any)
}



// 도전과제 4,5 : local + for 사용
## root 볼륨이 아닌 볼륨에 대한 값을 가지고 VG Volume 생성
locals {
  vg_volume = { for k, v in var.instance_volume_info : k => v.vol_size if substr(k, -4, -1) != "root"}
}



// 도전과제 5 : for_each 사용
# VG Volumes
resource "openstack_blockstorage_volume_v3" "instance_volumes_vg" {
  for_each = local.vg_volume
  name = "vg-${each.key}"
  size = each.value
  availability_zone = var.instance_volume_info[each.key].vol_az
  volume_type = split("-",var.instance_volume_info[each.key].vol_az)[0] != "db" ? var.default_vol_type :  var.instance_volume_info[each.key].vol_type
}