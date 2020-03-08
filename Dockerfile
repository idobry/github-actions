FROM dtzar/helm-kubectl

RUN wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz \
    && tar xf kubeval-linux-amd64.tar.gz \
    && cp kubeval /usr/local/bin
 
RUN helm plugin install https://github.com/instrumenta/helm-kubeval

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
