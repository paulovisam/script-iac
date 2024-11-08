#!/bin/bash

# Diretórios a serem removidos
directories=("/adm" "/publico" "/ven" "/sec")

# Usuários a serem removidos
users_adm=("carlos" "maria" "joao")
users_ven=("debora" "sebastiana" "roberto")
users_sec=("josefina" "amanda" "rogerio")

# Grupos a serem removidos
groups=("GRP_ADM" "GRP_SEC" "GRP_VEN")

# Removendo diretórios
for dir in "${directories[@]}"; do
    rm -Rf "$dir"
done

# Removendo usuários
for user in "${users_adm[@]}"; do
    userdel -r "$user"
done

for user in "${users_ven[@]}"; do
    userdel -r "$user"
done

for user in "${users_sec[@]}"; do
    userdel -r "$user"
done

# Removendo grupos
for group in "${groups[@]}"; do
    groupdel "$group"
done

#======================================================

echo "Criando diretórios..."
for dir in "${directories[@]}"; do
    mkdir -p "$dir"
done

echo "Criando Grupos..."
for group in "${groups[@]}"; do
    groupadd "$group"
done

echo "Criando usuários ADM..."
for user in "${users_adm[@]}"; do
    useradd "$user" -m -s /bin/bash -p 123 -G GRP_ADM
done


echo "Criando usuários VEN..."
for user in "${users_ven[@]}"; do
    useradd "$user" -m -s /bin/bash -p 123 -G GRP_VEN
done

echo "Criando usuários SEC..."
for user in "${users_sec[@]}"; do
    useradd "$user" -m -s /bin/bash -p 123 -G GRP_SEC
done

echo "Usuários e grupos criados com sucesso!"

echo "Especificando permisões..."
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

for dir in "${directories[@]}"; do
    chmod 770 "$dir"
done

chmod 777 /publico


