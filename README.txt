
# Diletta Sales HQ — Fullstack v0.5 (sem .env)

Tudo pronto em duas pastas:
- **backend/** (Node) — lê configurações de `backend/config.json` (visível e já preenchido)
- **flutter_app/** — app Flutter Web (tema claro/escuro, KPIs, funil, deals, assistant)

## Como rodar
### Terminal A — Backend
```
cd backend
npm install
npm start
```
Abre em http://localhost:8787

### Terminal B — Flutter Web
```
cd flutter_app
flutter pub get
flutter run -d chrome
```
O app abrirá no navegador consumindo o backend.

> Quando quiser trocar chaves/porta/domínio, edite `backend/config.json` (não é arquivo oculto).
