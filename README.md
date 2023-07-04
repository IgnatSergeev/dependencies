# dependencies
Apt репозиторий с необходимыми debian пакетами для сборки проекта ukazka

## Как собирать
FIXME: можно автоматизировать, если решить проблему с gpg ключами
1. Добавляете нужные команды в packagesCommandNames,
если нужно добавить уже собранные пакеты, то кидаете их в pool/main/ukazka-backend
2. Устанавливаете следующие пакеты: apt-ftparchive gpg gzip apt-rdepends

   ```apt -y install apt-ftparchive gpg gzip apt-rdepends```
3. Запускаете скрипт для загрузки всех пакетов для команд из packagesCommandNames:
   ```./scripts/download-packages.sh```

4. Создаете gpg ключ (https://gitlab.softcom.su/help/user/project/repository/gpg_signed_commits/index.md#create-a-gpg-key)
5. Запускаете скрипт build.sh с аргументом в виде приватного ключа

   ```build.sh MY_SUPER_KEY```

## Как использовать
Добавить в список apt репозиториев:

```git clone "https://${USERNAME}:${PASSWORD}@gitlab.softcom.su/ukazka/dependencies.git"```

```echo "deb [trusted=yes] file:$(pwd)/dependencies stable main" | sudo tee /etc/apt/sources.list.d/local.list```
