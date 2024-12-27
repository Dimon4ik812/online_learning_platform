FROM python:3.13-slim-bullseye AS builder-dns

RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf
RUN echo "nameserver 8.8.4.4" >> /etc/resolv.conf
FROM python:3.13-slim-bullseye AS builder
COPY --from=builder-dns /etc/resolv.conf /etc/resolv.conf
RUN curl -sSL https://install.python-poetry.org | python -
WORKDIR /app
ENV PATH="/root/.local/bin:${PATH}"
ENV PYTHONPATH="/app"
ENV POETRY_VIRTUALENVS_CREATE=false
COPY . .
RUN poetry install --only main
RUN poetry remove python-dotenv
RUN poetry add python-dotenv

FROM python:3.13-slim-bullseye AS final
COPY --from=builder /app /app

WORKDIR /app
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "wsgi.py :application"]

