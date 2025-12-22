# Домашнее задание к занятию «Организация сети»

## Задание 1. Yandex Cloud
### Что нужно сделать

1. Создать бакет Object Storage и разместить в нём файл с картинкой:
    - Создать бакет в Object Storage с произвольным именем (например, имя_студента_дата).
    - Положить в бакет файл с картинкой.
    - Сделать файл доступным из интернета.
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:
    - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать image_id = fd827b91d99psvq5fjit.
    - Для создания стартовой веб-страницы рекомендуется использовать раздел user_data в meta_data.
    - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
    - Настроить проверку состояния ВМ.
3. Подключить группу к сетевому балансировщику:
    - Создать сетевой балансировщик.
    - Проверить работоспособность, удалив одну или несколько ВМ.
(дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Полезные документы:
- [Compute instance group.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group)
- [Network Load Balancer.](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer)
- [Группа ВМ с сетевым балансировщиком.](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer)

# Ответ.

## [Ссылка на репозиторий с terraform проектом](https://github.com/Sem20071/hw-cloud-providers/tree/main/cloud-homeworks_2)

#### Бакет создан:
![Скриншот экрана 1](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-1.png)
#### Изображение размещено в созданном бакете и сделано общедоступным:
![Скриншот экрана 2](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-2.png)
#### Изображение доступно из интернета:
![Скриншот экрана 3](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-3.png)
#### Группа виртуальных машин создана:
![Скриншот экрана 4](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-4.png)
#### health check и целефая группа настроены:
![Скриншот экрана 5](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-5.png)
#### Сетевой балансировщик создан и настроен:
![Скриншот экрана 6](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-6.png)
#### Проверено, балансировщик отрабатывает нормально:
![Скриншот экрана 7](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-7-1.png)
![Скриншот экрана 8](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-7-2.png)
![Скриншот экрана 9](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-7-3.png)
#### Удалены 2 ВМ:
![Скриншот экрана 10](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-8-1.png)
#### Обе ВМ были автоматически пересозданы:
![Скриншот экрана 11](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-8-2.png)
#### health check пройден, все три машины работают штатно:
![Скриншот экрана 12](https://github.com/Sem20071/hw-cloud-providers/blob/main/cloud-homeworks_2/images/cloud-homeworks_2-9.png)

## [Ссылка на репозиторий с terraform проектом](https://github.com/Sem20071/hw-cloud-providers/tree/main/cloud-homeworks_2)