# Домашнее задание к занятию «Организация сети»

## Задание 1. Yandex Cloud
### Что нужно сделать

1. Создать пустую VPC. Выбрать зону.
2. Публичная подсеть.
    - Создать в VPC subnet с названием public, сетью 192.168.10.0/24.
    - Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1.
    - Создать в этой публичной подсети виртуалку с публичным IP, подключиться к ней и убедиться, что есть доступ к интернету.
3. Приватная подсеть.
    - Создать в VPC subnet с названием private, сетью 192.168.20.0/24.
    - Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс.
    - Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее, и убедиться, что есть доступ к интернету.

Resource Terraform для Yandex Cloud:
- [VPC subnet.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet)
- [Route table.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_route_table)
- [Compute Instance.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance)

# Ответ.
#### Созданные инстансы:
![Скриншот экрана 1](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-1.png)
#### Доступ в интернет с public ВМ и пинги private ВМ:
![Скриншот экрана 2](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-2.png)
#### Доступ в интернет с private ВМ и пинги public ВМ и шлюза:
![Скриншот экрана 3](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-3.png)
#### Созданный шлюз:
![Скриншот экрана 4](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-4.png)
#### Созданная группа безопасности:
![Скриншот экрана 5](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-5.png)
#### Созданная таблица маршрутизации:
![Скриншот экрана 6](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-6.png)
#### Созданные подсети и привязанная таблица маршрутизации:
![Скриншот экрана 7](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_1/images/cloud-homeworks_1-7.png)

## [Ссылка на репозиторий с terraform проектом](https://github.com/Sem20071/hw-cloud-providers/tree/main/cloud-homeworks_1)