locals {
  security_group_ids = {
    "private" = [yandex_vpc_security_group.private.id]
    "none"    = null
  }
  image_public_url = "https://storage.yandexcloud.net/${yandex_storage_bucket.my_bucket.bucket}/${yandex_storage_object.my_image.key}"

}