sudo apt-get install mariadb-server
# sudo apt-get install galera-4 #-> already exist in mariadb-server
#cp /vagrant/roles/mariadb-galera/.. /usr/share/mysql/wsrep.cnf
sudo nano  /etc/mysql/conf.d/galera.cnf
sudo systemctl stop mariadb
sudo galera_new_cluster

sudo mysql -u root -p -e "SHOW STATUS LIKE 'wsrep_cluster_size'"

sudo mysql -u root -p -e 'CREATE DATABASE playground;
CREATE TABLE playground.equipment ( id INT NOT NULL AUTO_INCREMENT, type VARCHAR(50), quant INT, color VARCHAR(25), PRIMARY KEY(id));
INSERT INTO playground.equipment (type, quant, color) VALUES ("slide", 2, "blue");'

mysql -u root -p -e 'SELECT * FROM playground.equipment;'