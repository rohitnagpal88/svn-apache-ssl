# svn-apache-ssl

Update ssl certificates files in repo root and corresponding cert/key name in Dockerfile.

Build docker image :-

docker build -t svn-apache-ssl .

Run image:-

docker run -d --name svn-apache-ssl -v <hostpath>:/home/svn -p 443:443 svn-apache-ssl:latest

Create repo:-

docker exec -it svn-apache-ssl svnadmin create /home/svn/testrepo
docker exec -it svn-apache-ssl chown -R www-data:www-data /home/svn/testrepo/

Create user:-

docker exec -it svn-apache-ssl htpasswd -cm /etc/apache2/dav_svn.passwd admin
