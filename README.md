# KaMovie Repository
This is my self-hosted repository for my media server

The separated folder contains separate compose files depending on the services you with to deploy
to install run the following script
```
  sudo dnf -y install git
  cd ~
  git clone https://github.com/mdwachira/kamovie.git compose
  cd ./compose
  sudo chmod +x install.sh
  ./install.sh
```


## ERPNext Setup
#### Please see below script to set up ERPNext.
Step 1: Set up your initial ErpNext Site
```
docker exec erpnext-backend \
  bench new-site one.example.com --mariadb-root-password StrongPassw0rd --install-app erpnext --admin-password StrongPassw0rd
```
Step 2: Set up an additional site
```
docker exec backend \
  bench new-site two.example.com --mariadb-root-password StrongPassw0rd --install-app erpnext --admin-password StrongPassw0rd
```

#### You can install adittional modules using the below comands
Install Payments module
```
docker exec erpnext-backend \
  bench get-app payments --resolve-deps --branch version-15 && bench --site one.example.com install-app payments
```
Install Frappe HR module
```
docker exec erpnext-backend \
  bench get-app hrms --branch version-15 && bench --site one.example.com install-app hrms
```
Install Frappe Helpdesk module
```
docker exec erpnext-backend \
  bench get-app helpdesk --resolve-deps --branch version-15 && bench --site one.example.com install-app helpdesk
```
Install Frappe Insights module
```
docker exec erpnext-backend \
  bench get-app insights --resolve-deps --branch version-15 && bench --site one.example.com install-app insights
```
Install Frappe Chat module
```
docker exec erpnext-backend \
  bench get-app chat --resolve-deps --branch version-15 && bench --site one.example.com install-app chat
```
Install Frappe Drive module
```
docker exec erpnext-backend \
  bench get-app drive --resolve-deps --branch version-15 && bench --site one.example.com install-app drive
```
Install Kenya Tax Customizations
```
docker exec erpnext-backend \
  bench get-app https://github.com/navariltd/CSF_KE.git --resolve-deps && bench --site one.example.com install-app csf_ke
```