FROM python:3.8-slim

ARG USER=boto

RUN useradd -ms /bin/bash ${USER}
USER ${USER}

WORKDIR /home/${USER}

COPY . .
RUN mkdir /home/${USER}/.aws && \
    mv config /home/${USER}/.aws && \
    mv credentials /home/${USER}/.aws && \
    cat /home/${USER}/.aws/config && \
    cat /home/${USER}/.aws/credentials && \
    pip install -r requirements.txt 

CMD ["python", "run.py"]
