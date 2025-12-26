resource "yandex_mdb_mysql_cluster" "cluster-mysql" {
  name                = var.mysql_resources.mysql_cluster_name
  environment         = "PRESTABLE"
  network_id          = yandex_vpc_network.aleksandrov-vpc.id
  version             = "8.4" 
  deletion_protection = true   # Защита от удаления

  backup_window_start {
    hours   = 23
    minutes = 59
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "MON"
    hour = 3
  }

  resources {
    resource_preset_id = var.mysql_resources.resource_preset
    disk_type_id       = var.mysql_resources.disk_type
    disk_size          = var.mysql_resources.disk_size
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.subnets["private-ru-central1-a"].id
    assign_public_ip = true
  }

  host {
    zone       = "ru-central1-b"
    subnet_id  = yandex_vpc_subnet.subnets["private-ru-central1-b"].id
    assign_public_ip = false
  }

  mysql_config = {
    max_connections = var.mysql_resources.max_connections
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    sql_mode = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    innodb_print_all_deadlocks = true
  }
}

resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.cluster-mysql.id
  name       = var.db_name
}

resource "yandex_mdb_mysql_user" "alex_user" {
  cluster_id = yandex_mdb_mysql_cluster.cluster-mysql.id
  name       = var.mysql_user
  password   = var.mysql_password
  
  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }
}
