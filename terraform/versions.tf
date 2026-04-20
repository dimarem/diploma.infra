terraform {
  required_version = "~> 1.5"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.87.0"
    }
  }

  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket   = "std-046-13-s3-storage"
    region   = "ru-central1"
    key      = "terraform.tfstate"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
