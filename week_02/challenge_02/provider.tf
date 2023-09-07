# 도전과제2
# 위 3개 코드 파일 내용에 리소스의 이름(myvpc, mysubnet1 등)을 반드시! 꼭! 자신의 닉네임으로 변경해서 배포 실습해보세요!
#-> 리소스의 유형과 리소스의 이름이 차이를 알고, 리소스의 속성(예. ID)를 참조하는 방법에 대해서 익숙해지자


terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.15.0"
    }
  }
}