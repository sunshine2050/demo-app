FROM python:3.9
WORKDIR /python-docker
COPY src/ .
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENV ACCEPT_EULA Y
RUN apt-get update \
 && apt-get install --yes --no-install-recommends \
        apt-transport-https \
        curl \
        gnupg \
        unixodbc-dev \
 && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
 && curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
 && apt-get update \
 && ACCEPT_EULA=Y apt-get install --yes --no-install-recommends msodbcsql18 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/*
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]