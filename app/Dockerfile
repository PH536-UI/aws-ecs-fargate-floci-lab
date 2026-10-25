FROM python:3.12-alpine

RUN addgroup -S app && adduser -S app -G app
WORKDIR /app
COPY server.py /app/server.py
RUN chown -R app:app /app

USER app
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD python -c "import urllib.request; urllib.request.urlopen(http://127.0.0.1:8080/health)"

ENV PORT=8080 APP_NAME=ph-ecs-demo APP_VERSION=1.0.0
CMD ["python", "/app/server.py"]
