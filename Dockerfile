#IA 462 Midterm Aaron
#builder iamge
FROM python:3.15-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928 AS builder

LABEL maintainer="awolf11@emich.edu"
LABEL description="IA 462 Midterm - Supply-Chain-Hardened App"

#copy requirements
WORKDIR /build
COPY requirements.lock .
COPY updateSetupTools.lock .

#install requirements
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir --require-hashes -r requirements.lock

#update setuptools for trivy
RUN pip install  --no-cache-dir --upgrade --force-reinstall --require-hashes -r updateSetupTools.lock


#runtime image
FROM python:3.15-slim@sha256:65a65fc7b30b06cb6df4930fd4650697cb23f4c2698ab81fc87e4b031bc36928 AS runtime

#update zlib for trivy scan
RUN apt-get update \
    && apt-get install -y --only-upgrade zlib1g \
    && rm -rf /var/lib/apt/lists/*

#create non root user
RUN groupadd --system appgroup && \
    useradd  --system --gid appgroup --home /app --shell /usr/sbin/nologin appuser

#update setuptools for trivy
WORKDIR /tmp
COPY updateSetupTools.lock .
RUN pip install  --no-cache-dir --upgrade --force-reinstall --require-hashes -r updateSetupTools.lock
RUN rm -rf /tmp

#add venv to path
ENV PATH="/opt/venv/bin:$PATH"

#copy files
WORKDIR /app
COPY --from=builder /opt/venv /opt/venv
COPY --chown=appuser:appgroup app/ ./app/

#run image
USER appuser
EXPOSE 5000
CMD ["python3", "app/app.py"]
