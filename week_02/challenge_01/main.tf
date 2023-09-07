# 도전과제 1
# 리전 내에서 사용 가능한 가용영역 목록 가져오기를 사용한 VPC 리소스 생성 실습 진행


# Default VPC
data "aws_vpc" "default_vpc" {
  id = "vpc-07b2cc8e9a65f2ccb"
}

# Default AZ
## filter argument 확인 url : https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeAvailabilityZones.html
data "aws_availability_zones" "example" {
  all_availability_zones = true

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

# Check
output "AZ_list" {
  value = data.aws_availability_zones.example.names
}