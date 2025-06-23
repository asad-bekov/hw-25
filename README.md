# Домашнее задание к занятию 1 «Введение в Ansible»

> Репозиторий: **hw‑25**  
> Выполнил: **Асадбеков Асадбек**  
> Дата выполнения: **июнь 2025**
---

## Содержание

1. [Установка Ansible](#установка-ansible)
2. [Запуск playbook на test.yml](#запуск-playbook-на-testyml)
3. [Изменение значения some_fact](#изменение-значения-some_fact)
4. [Работа с prod.yml и docker](#работа-с-prodyml-и-docker)
5. [Группы и переменные](#группы-и-переменные)
6. [Ansible Vault](#ansible-vault)
7. [Подключение localhost](#подключение-localhost)
8. [Шифрование строки PaSSw0rd](#шифрование-строки-passw0rd)
9. [Добавление fedora](#добавление-fedora)
10. [Автоматизация скриптом](#автоматизация-скриптом)
11. [Скриншоты](#скриншоты)
---

## Установка Ansible

```bash
python3 -m venv ~/ansible-venv
source ~/ansible-venv/bin/activate
pip install ansible==2.14
ansible --version
```
![ansible --version](https://github.com/asad-bekov/hw-25/raw/main/img/1.png)
---

## Запуск playbook на test.yml

```bash
ansible-playbook -i inventory/test.yml site.yml
```

Вывод: `some_fact: all default fact`
![Вывод `some_fact`](https://github.com/asad-bekov/hw-25/raw/main/img/3.png)
---

## Изменение значения some_fact

В файле `group_vars/all/exmp.yml` изменено:

```yaml
some_fact: all default fact
```
![Изменение `some_fact`](https://github.com/asad-bekov/hw-25/raw/main/img/4.png)
---

## Работа с prod.yml и docker

- Подняты контейнеры: debian, centos
- inventory/prod.yml настроен с `ansible_connection: docker`

Проверка подключения:

```bash
ansible -i inventory/prod.yml all -m ping
```
![Вывод `some_fact`](https://github.com/asad-bekov/hw-25/raw/main/img/5.png)
---

## Группы и переменные

Настроены переменные:

- `group_vars/debian/main.yml`: `deb default fact`
- `group_vars/centos/main.yml`: `el default fact`

![](https://github.com/asad-bekov/hw-25/raw/main/img/7.png)
---

## Ansible Vault

Шаги:

```bash
ansible-vault encrypt group_vars/debian/main.yml
ansible-vault encrypt group_vars/centos/main.yml
ansible-playbook -i inventory/prod.yml site.yml --ask-vault-pass
```

Значения корректно считываются после ввода пароля `netology`.

![](https://github.com/asad-bekov/hw-25/raw/main/img/8.png)

---

## Подключение localhost

Добавлено:

```yaml
localhost:
  ansible_connection: local
```

`group_vars/local/main.yml` → `some_fact: local default fact`

![](https://github.com/asad-bekov/hw-25/raw/main/img/9.png)
---

## Шифрование строки PaSSw0rd

```bash
ansible-vault encrypt_string 'PaSSw0rd' --name 'some_fact'
```

Добавлено в `group_vars/all/exmp.yml`.

![](https://github.com/asad-bekov/hw-25/raw/main/img/10.png)
---

## Добавление fedora

Добавлен контейнер:

```bash
docker run -d --name fedora_host pycontribs/fedora sleep infinity
```

Добавлено в `inventory/prod.yml` и `group_vars/fedora/main.yml`

![](https://github.com/asad-bekov/hw-25/raw/main/img/11.png)
---

## Автоматизация скриптом

Файл: `run_playbook.sh`

```bash
docker run ...
ansible-playbook ...
docker stop ...
```
---

## Vault

**Пароль:** `netology` (вводится при запросе, не хранится)
---
