FROM httpd:alpine3.15
ARG domain
ARG prefix="http://"


RUN test -n "$domain" || (echo "ERROR: domain is not set" && false)


RUN sed -i 's/#LoadModule headers_module/LoadModule headers_module/g' /usr/local/apache2/conf/httpd.conf
RUN echo 'Header set Access-Control-Allow-Origin "*"' >> /usr/local/apache2/conf/httpd.conf
RUN echo 'Header set Access-Control-Allow-Methods "GET, POST, OPTIONS"' >> /usr/local/apache2/conf/httpd.conf
RUN echo 'Header set Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept"' >> /usr/local/apache2/conf/httpd.conf


COPY . /usr/local/apache2/htdocs/


RUN sed -i -e "s|{domain}|$domain|" -e "s|{PREFIX}|$prefix|" /usr/local/apache2/htdocs/msx/start.json
