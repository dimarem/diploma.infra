resource "yandex_storage_bucket" "iam-bucket" {
  bucket    = var.image_bucket_name
  folder_id = var.folder_id
  max_size  = var.image_bucket_size

  anonymous_access_flags {
    read        = true
    list        = true
    config_read = false
  }
}
