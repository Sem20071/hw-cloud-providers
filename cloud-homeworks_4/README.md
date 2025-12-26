# Задание 1. Yandex Cloud

1. Настроить с помощью Terraform кластер баз данных MySQL.
    - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно подсеть private в разных зонах, чтобы обеспечить отказоустойчивость.
    - Разместить ноды кластера MySQL в разных подсетях.
    - Необходимо предусмотреть репликацию с произвольным временем технического обслуживания.
    - Использовать окружение Prestable, платформу Intel Broadwell с производительностью 50% CPU и размером диска 20 Гб.
    - Задать время начала резервного копирования — 23:59.
    - Включить защиту кластера от непреднамеренного удаления.
    - Создать БД с именем netology_db, логином и паролем.
2. Настроить с помощью Terraform кластер Kubernetes.
    - Используя настройки VPC из предыдущих домашних заданий, добавить дополнительно две подсети public в разных зонах, чтобы обеспечить отказоустойчивость.
    - Создать отдельный сервис-аккаунт с необходимыми правами.
    - Создать региональный мастер Kubernetes с размещением нод в трёх разных подсетях.
    - Добавить возможность шифрования ключом из KMS, созданным в предыдущем домашнем задании.
    - Создать группу узлов, состояющую из трёх машин с автомасштабированием до шести.
    - Подключиться к кластеру с помощью kubectl.
* Запустить микросервис phpmyadmin и подключиться к ранее созданной БД.
* Создать сервис-типы Load Balancer и подключиться к phpmyadmin. Предоставить скриншот с публичным адресом и подключением к БД.

Полезные документы:

[MySQL cluster.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mysql_cluster)
[Создание кластера Kubernetes](https://cloud.yandex.ru/docs/managed-kubernetes/operations/kubernetes-cluster/kubernetes-cluster-create)
[K8S Cluster.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_cluster)
[K8S node group.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kubernetes_node_group)

# Ответ.
## [Ссылка на репозиторий с terraform проектом](https://github.com/Sem20071/hw-cloud-providers/tree/main/cloud-homeworks_4)

#### Дополнительные подсети public и private созданы в разных зонах:
![Скриншот экрана 1](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-0.png)

#### Кластер mysql развернут ноды размещены в разных подсетях:
![Скриншот экрана 2](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-1.png)
![Скриншот экрана 3](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-2.png)
#### Параметры кластера в соответствии с заданием:
![Скриншот экрана 4](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-4.png)
#### БД с именем netology_db создана:
![Скриншот экрана 4-1](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-5.png)


#### Кластер k8s развернут:
![Скриншот экрана 5](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-8.png)
#### Региональный мастер Kubernetes с размещением в трех разных подсетях создан:
![Скриншот экрана 6](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-8-1.png)
#### Возможность шифрования ключем из KMS добавлена:
#### Группа узлов из 3х машин с автомаштабированием:
![Скриншот экрана 8](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-8-3.png)

#### Подключение к Kubernetes кластеру прпомощи kubectl:
![Скриншот экрана 9](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-9.png)
#### Запущен микросервис phpmyadmin подключен к ранее созданной БД:
![Скриншот экрана 10](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_4/images/cloud-homeworks_4-1-12.png)

## [Ссылка на репозиторий с terraform проектом](https://github.com/Sem20071/hw-cloud-providers/tree/main/cloud-homeworks_4)