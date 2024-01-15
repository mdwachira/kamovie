# KaMovie Repository
This is my self-hosted repository for my media server

The separated folder contains separate compose files depending on the services you with to deploy



Please see below script to set up ERPNext.
Step 1: Set up initial side
```
docker exec erpnext-backend \
  bench new-site one.example.com --mariadb-root-password StrongPassw0rd --install-app erpnext --admin-password StrongPassw0rd
```
Step 2: Set up additional site
```
docker exec backend \
  bench new-site two.example.com --mariadb-root-password StrongPassw0rd --install-app erpnext --admin-password StrongPassw0rd
```
Step 3: Install payments module
```
docker exec erpnext-backend \
  bench get-app payments --branch version-15 && bench --site demo.enext.duckdns.org install-app payments
```
Step 4: Install Frappe HR module
```
docker exec erpnext-backend \
  bench get-app hrms --branch version-15 && bench --site demo.enext.duckdns.org install-app hrms
```