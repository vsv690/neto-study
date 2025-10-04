# Домашнее задание к занятию 2. «Применение принципов IaaC в работе с виртуальными машинами»

## Задача 3

Решением задачи являются файлы в директории src:
1. [mydebian.pkr.hcl](https://github.com/netology-code/virtd-homeworks/blob/shvirtd-1/05-virt-02-iaac/src/mydebian.json.pkr.hcl) - здесь токен подтягивается из локального файла.
2. [mydebian.jsonl](https://github.com/netology-code/virtd-homeworks/blob/shvirtd-1/05-virt-02-iaac/src/mydebian.json) - здесь токен указывается вручную.
(packer умеет и в json, и в hcl форматы).

С Vagrant не вышло из-за ограничений на скачивание провайдеров, даже ручной режим не помог. 