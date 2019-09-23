### BITESTOQUE ###

App BitEstoque

Aplicativo para gerenciamento de estoque. Desenvolvido para fins de estudos de desenvolvimento (programação - dev).

## Ferramentas utilizadas:

- ruby 2.5.1
- rails 5.2.0
- postgres
- puma
- coffee rails
- jquery rails
- bootstrap
- rspec-rails
- ffaker
- factory bot rails
- database cleaner
- shoulda matchers
- rails-controller-testing

## Executado utilizando Docker:

- Dockerfile
- docker-compose version 3

## Execução de testes automatizados:

```
docker-compose run --rm app bundle exec rspec spec/*
```

## Execução:

```
docker-compose build

docker-compose run --rm app bundle install

docker-compose run --rm app bundle exec rails db:create db:migrate db:seed

docker-compose up
```
