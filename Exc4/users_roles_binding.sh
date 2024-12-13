#!/bin/bash

ROLEBINDING_FILE="rolebinding.yaml"

if [[ -f "$ROLEBINDING_FILE" ]]; then
  kubectl apply -f "$ROLEBINDING_FILE"
  echo "Связи пользователей с ролями из файла $ROLEBINDING_FILE успешно созданы."
else
  echo "Файл $ROLEBINDING_FILE не найден. Проверьте путь и попробуйте снова."
  exit 1
fi
