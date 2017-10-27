FROM python:2.7-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    postgresql-client \
    libpq-dev \
    git-core \
		build-essential

RUN pip install virtualenv virtualenvwrapper requests

RUN mkdir -p /usr/lib/ckan/default

RUN /bin/bash -c "source /usr/local/bin/virtualenvwrapper.sh"

RUN virtualenv --no-site-packages /usr/lib/ckan/default

RUN . /usr/lib/ckan/default/bin/activate

RUN pip install -e 'git+https://github.com/andela/ckan.git@ckan-2.6.3#egg=ckan'

RUN pip install -r /src/ckan/requirements.txt

RUN pip install --upgrade bleach

# Install OpenAfrica Extension
RUN pip install -e git+https://github.com/andela/ckanext-openafrica.git#egg=ckanext-openafrica

# Install Datarequests Extension
RUN pip install -e git+https://github.com/andela/ckanext-datarequests.git@add-voting-feature#egg=ckanext-datarequests

# Install Social Extension
RUN pip install -e git+https://github.com/edmondatto/ckanext-social.git@develop#egg=ckanext-social

# Install Followy Extension
RUN pip install -e git+https://github.com/andela/ckanext-followy.git@develop#egg=ckanext-followy

# Install Socialite Extension
RUN pip install -e git+https://github.com/codeforafricalabs/ckanext-socialite.git@1-add_facebook_auth#egg=ckanext-socialite

# Install PDF View Extension
RUN pip install -e git+https://github.com/ckan/ckanext-pdfview.git#egg=ckanext-pdfview

RUN mkdir -p /etc/ckan/default

COPY ./default.ini /etc/ckan/default

RUN ln -s /src/ckan/who.ini /etc/ckan/default/who.ini

COPY ./docker-entrypoint.sh /
