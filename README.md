
# my-glpi-app
 docker glpi app on container httpd-php and mariadb

##### Pour la création d'une image avec le docker file, 
##### veuillez renommé le fichier en dockerfile au lieu de dockerfile-mariadb ou dockerfile-glpi

Si vous possedez un proxy n'oubliez d'ajouter l'adresse IP et le port du proxy en Variable d'environnement comme suit :

ENV http_proxy http://adresseIP:Port

##### Creation image glpi utilisant le contenu du fichier dockerfile-glpi et en ce plaçant de même repertoire que celui-ci

 docker build -t glpi .

##### Creation image mariadb personnalisé utilisant le contenu du fichier dockerfile-mariadb et en ce plaçant de même repertoire que celui-ci

 docker build -t mariadb .

##### Démarrage du container Mariadb sous le nom my-mariadb

docker run --name my-mariadb --detach --env="MYSQL-ROOT_PASSWORD=admin" mariadb

##### Démarrage du container GLPI sous le nom my-glpi-app avec exposition d'un port externe 3303 puis connection à mariadb

docker run -d -p 3033:80 --name my-glpi-app --link my-mariadb:mariadb glpi

##### Test de la bonne liaison entre les deux containers 

docker exec -it my-glpi-app bash
##### avec le bash faire

cat /etc/hosts/

##### vous verrez le nom du container mariadb dedans
#####
##### Tester l'installation de GLPI avec le navigateur web en utilisant
localhost:3033

###########################################################################################
