FROM xqdocker/ubuntu-nginx

COPY dist /data/www/
COPY nginx-default.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
RUN service nginx start
