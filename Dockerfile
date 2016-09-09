# CoMSES miracle docker image for radiant and shiny server

# Mount Points
# /var/log/shiny-server.log     log file
# /miracle/projects             project files

FROM comses/miracle-r

ENV PROJECTS_PATH   /miracle/projects
ENV OWNER           comses
ARG SHINY_SERVER_VERSION=1.4.4.801
ARG SHINY_RPM=shiny-server-$SHINY_SERVER_VERSION-rh5-x86_64.rpm

USER root
WORKDIR /opt/


# Install Shiny Server
RUN wget https://download3.rstudio.org/centos5.9/x86_64/$SHINY_RPM \
        && yum install -y --nogpgcheck $SHINY_RPM && rm -f $SHINY_RPM \
        # Install Radiant
        && git clone --depth 1 https://github.com/warmdev/radiant-mod.git radiant \
        && mv radiant /srv/shiny-server \
        && cp -r /srv/shiny-server/radiant/inst/* /srv/shiny-server \
        && cp -r /srv/shiny-server/radiant/R /srv \
        && rm -rf /srv/shiny-server/radiant \
# Configure Shiny and Radiant
# ---------------------------
        && sed -i -e "s/run_as shiny/run_as $OWNER/g" /etc/shiny-server/shiny-server.conf \
        && mkdir -p $PROJECTS_PATH \
        && ln -s $PROJECTS_PATH /srv/shiny-server/miracle \
        && chown -R $OWNER: $PROJECTS_PATH /srv/shiny-server \
# Create a log file
        && mkdir -p /var/log/shiny-server \
        && touch /var/log/shiny-server.log \
        && chown -R $OWNER: /var/log/shiny-server \
        && yum clean all

USER $OWNER
EXPOSE 3838
CMD ["/usr/bin/shiny-server"]
