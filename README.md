# KaMovie Repository
This is my self-hosted repository for my media server

The separated folder contains separate compose files depending on the services you with to deploy



Please see below script to be run to set up Frappe HR
```
docker compose exec erpnext-backend \
  bench new-site one.example.com --mariadb-root-password StrongPassw0rd --install-app erpnext --admin-password StrongPassw0rd

docker compose --project-name erpnext-one exec backend \
  bench new-site two.example.com --mariadb-root-password StrongPassw0rd --install-app erpnext --admin-password StrongPassw0rd

docker exec erpnext-backend \
  bench get-app payments --branch version-15 && bench --site demo.enext.duckdns.org install-app payments

docker exec erpnext-backend \
  bench get-app hrms --branch version-15 && bench --site demo.enext.duckdns.org install-app hrms
```