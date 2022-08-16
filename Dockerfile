FROM python:3.8-slim

ARG USER=boto

RUN useradd -ms /bin/bash ${USER}
USER ${USER}

WORKDIR /home/${USER}

COPY . .
RUN pip install -r requirements.txt 

CMD ["python", "run.py"]
