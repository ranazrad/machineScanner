FROM python:3.8-slim

ARG USER=boto

RUN useradd -ms /bin/bash ${USER}
USER ${USER}

WORKDIR /home/${USER}

COPY . .
RUN mkdir /home/${USER}/.aws && \
    echo [default] > /home/${USER}/.aws/config && \
    echo $AWS_REGION >> /home/${USER}/.aws/config && \
    echo [default] > /home/${USER}/.aws/credentials && \
    echo $AWS_ACCESS_KEY_ID >> /home/${USER}/.aws/credentials && \
    echo $AWS_SECRET_ACCESS_KEY >> /home/${USER}/.aws/credentials && \
    echo $AWS_SESSION_TOKEN >> /home/${USER}/.aws/credentials && \
    ls -la /home/${USER}/.aws
RUN cat /home/${USER}/.aws/config
RUN cat /home/${USER}/.aws/credentials && \
    pip install -r requirements.txt 

CMD ["python", "run.py"]
