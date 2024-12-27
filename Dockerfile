FROM python:3.13 AS builder
RUN curl -sSL https://install.python-poetry.org | python -
WORKDIR /app
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/app"
ENV POETRY_VIRTUALENVS_CREATE=false
COPY . .
RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN echo "nameserver 8.8.4.4" >> /etc/resolv.conf
RUN poetry install --only main
RUN poetry remove python-dotenv
RUN poetry add python-dotenv

