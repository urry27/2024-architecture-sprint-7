#!/bin/bash

ROLE_FILE="role.yaml"

if [[ -f "$ROLE_FILE" ]]; then
  kubectl apply -f "$ROLE_FILE"
  echo "Роли из файла $ROLE_FILE успешно созданы."
else
  echo "Файл $ROLE_FILE не найден. Проверьте путь и попробуйте снова."
  exit 1
fi