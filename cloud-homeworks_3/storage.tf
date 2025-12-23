resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-encryption-key"
  description       = "KMS key for S3 bucket encryption"
  default_algorithm = "AES_256"
  rotation_period   = "168h"
}

resource "yandex_storage_bucket" "my_bucket" {
  bucket = "${var.bucket_name}-${formatdate("YYYY-MM-DD", timestamp())}"
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
  anonymous_access_flags {
    read = true
    list = false
  }
}

resource "yandex_storage_object" "my_image" {
  bucket       = yandex_storage_bucket.my_bucket.bucket
  key          = "image.png"
  source       = "./images/image.png"
  content_type = "image/png"
  depends_on   = [yandex_storage_bucket.my_bucket]
}
