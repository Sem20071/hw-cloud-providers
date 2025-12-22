resource "yandex_storage_bucket" "my_bucket" {
  bucket = "${var.bucket_name}-${formatdate("YYYY-MM-DD", timestamp())}"
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
