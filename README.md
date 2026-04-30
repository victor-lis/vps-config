# 🚀 VPS Config — Configurações rápidas para seu VPS com Docker

![status: ready](https://img.shields.io/badge/status-ready-green) ![docker](https://img.shields.io/badge/docker-ready-blue) ![shield](https://img.shields.io/badge/setup-easy-orange)

Repositório com templates e configurações para subir serviços úteis em um VPS usando Docker Compose. Ideal para testes, recuperação ou provisionamento rápido de pequenos ambientes.

---

## 🧩 Serviços incluídos (definidos em [`docker-compose.yml`](docker-compose.yml))

- 🗄️ Postgres — [`docker-compose.yml:services.postgres`](docker-compose.yml)  
  - Imagem: bitnami/postgresql  
  - Variáveis: veja [postgres/.env.example](postgres/.env.example)  
  - Volume: `./postgres/data`

- 🤖 n8n — [`docker-compose.yml:services.n8n`](docker-compose.yml)  
  - Imagem: n8nio/n8n  
  - Variáveis: veja [n8n/.env.example](n8n/.env.example)  
  - Config: [n8n/config](n8n/config)  
  - Volume: `./n8n`

- 🔌 MQTT (Mosquitto) — [`docker-compose.yml:services.mqtt`](docker-compose.yml)  
  - Configuração: [mqtt/config/mosquitto.conf](mqtt/config/mosquitto.conf)  
  - Variáveis (Usuários): veja [mqtt/.env.example](mqtt/.env.example) (Gerado dinamicamente no boot)
  - Volumes: `./mqtt/config`, `./mqtt/data`, `./mqtt/log`

- 🧭 Portainer — [`docker-compose.yml:services.portainer`](docker-compose.yml)  
  - Imagem: portainer/portainer-ce  
  - Volume: `./portainer/data`

- 🧩 Evolution API — [`docker-compose.yml:services.evolution`](docker-compose.yml)  
  - Imagem: atendai/evolution-api  
  - Variáveis: [evolution/.env.example](evolution/.env.example)  
  - Volume: `./evolution`

- 🔁 Redis — [`docker-compose.yml:services.redis`](docker-compose.yml)  
  - Usado onde necessário pelo ambiente

---

## 📂 Estrutura principal

- [`docker-compose.yml`](docker-compose.yml) — orquestração dos serviços  
- [`.gitignore`](.gitignore) — evita comitar dados/senhas (ex.: `*.env`, `*/data`, `*/log`)  
- [`.github/workflows/restart.yaml`](.github/workflows/restart.yaml) — workflow para atualizar/reiniciar remoto via SSH  
- [`.github/workflows/restart.yaml`](.github/workflows/restart.yaml) — workflow para atualizar/reiniciar remoto via SSH  
- Exemplos de variáveis: [postgres/.env.example](postgres/.env.example), [n8n/.env.example](n8n/.env.example), [evolution/.env.example](evolution/.env.example), [mqtt/.env.example](mqtt/.env.example)

---

## ⚙️ Pré-requisitos

- git
- docker
- docker-compose

---

## ⚡ Início rápido

1) Clone:
```bash
git clone <url-do-repositorio>
cd vps-config
```

2) Crie seus arquivos .env a partir dos exemplos:
```bash
cp postgres/.env.example postgres/.env
cp n8n/.env.example n8n/.env
cp n8n/.env.example n8n/.env
cp evolution/.env.example evolution/.env
cp mqtt/.env.example mqtt/.env
# ajustar senhas e chaves antes de subir
```

3) Suba os serviços:
```bash
docker-compose up -d
```

4) Logs e gerenciamento:
```bash
docker-compose logs -f <serviço>
docker-compose up -d --force-recreate --build <serviço>
docker-compose stop <serviço>
docker-compose start <serviço>
```

---

## 💾 Backup (ex.: Postgres)

1. Pare o serviço:
```bash
docker-compose stop postgres
```
2. Substitua `./postgres/data` pelo backup.
3. Reinicie:
```bash
docker-compose up -d postgres
```

---

## 🔒 Boas práticas

- Não comite secrets; use os `.env` e mantenha-os no `.gitignore` ([`.gitignore`](.gitignore)).  
- Faça backups regulares dos volumes (`postgres/data`, `n8n/`, etc.).  
- Em produção, considere secrets managers e volumes externos.

---

## 🔁 Deploy remoto

Existe um workflow para reiniciar no servidor remoto via SSH: [`.github/workflows/restart.yaml`](.github/workflows/restart.yaml). Configure os secrets (`SSH_PRIVATE_KEY`, `REMOTE_HOST`) no GitHub Actions antes de usar.

---

## ✉️ Contribuições & suporte

Abra uma issue ou envie um pull request. Se precisar de adaptação nas portas/volumes/serviços, descreva e será ajustado no [`docker-compose.yml`](docker-compose.yml).

---

## 👤 Autor

**Victor Lis Bronzo**  
[LinkedIn](https://www.linkedin.com/in/victor-lis-bronzo) • [GitHub](https://github.com/Victor-Lis)
