FROM python:3.10.0-bullseye

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Oslo

RUN apt-get update && apt-get install -y gnupg software-properties-common curl
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get update && apt-get install terraform

RUN pip install --upgrade pip
RUN useradd -m -s /bin/bash arturo_devops
USER arturo_devops
ENV PATH "$PATH:/home/arturo_devops/.local/bin"
COPY ./requirements.txt ./requirements.txt

RUN pip install -r requirements.txt
# ENV PYTHONPATH "${PYTHONPATH}" # Add if necessary

ENTRYPOINT ["bash"]
