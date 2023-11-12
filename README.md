## Reserva de Sala de Reunião

![Coverage Status](https://img.shields.io/badge/Ruby-3.1.2-green)
![Coverage Status](https://img.shields.io/badge/Rails-7.1.1-green)
![Coverage Status](https://img.shields.io/badge/Postgresql-14.9.0-green)

## Conteúdo

- [Descrição](#descrição)
- [Iniciando](#iniciando)
- [Rodando Testes](#rodando-testes)

## Descrição

Sala de Reunião é uma aplicação em Ruby on Rails que gerencia as reservas de uma sala de reunião.<br>
A aplicação permite que um usuário logado realize a reserva da sala de reunião, edite ou cancele a própria reserva e visualize qualquer reserva já realizada.

## Iniciando
### 1. Instalando rbenv
```sh
sudo apt install rbenv
```
### 2. Instalando Ruby
#### - Instalar ruby:
```shell
rbenv install 3.1.2
```
#### - Verificar se o Ruby foi corretamente instalado
```shell
ruby -v
```

### 3. Instalando Bundler
```shell
gem install bundler
```

### 4. Instalando Postgresql
```sh
    sudo apt install -y postgresql postgresql-contrib libpq-dev build-essential
    sudo /etc/init.d/postgresql start
    sudo -u postgres psql --command "CREATE ROLE \"`whoami`\" LOGIN createdb superuser;"
    sudo echo "`whoami` ALL=NOPASSWD:/etc/init.d/postgresql start" | sudo tee /etc/sudoers.d/postgresql
    sudo chmod 440 /etc/sudoers.d/postgresql
```

### 5. Rodando a aplicação
```shell
gh repo clone bdellacoletta/sala_de_reuniao
cd sala_de_reuniao
rbenv local 3.1.2
bundle install
rails db:create
rails db:migrate
rails db:seed
```

- Rodar a aplicação
```shell
rails s
```

## Rodando Testes
Rode os testes com o comando `bundle exec rspec` ou `bundle exec rspec spec/<path_to_spec>`<br>
Para rodar o teste de integração é necessário que o navegador Firefox esteja instalado em sua máquina. 
