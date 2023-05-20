FROM python

LABEL maintainer="Carson Gee <x@carsongee.com>" \
  org.label-schema.name="Drone Poetry" \
  org.label-schema.vendor="Carson Gee" \
  org.label-schema.schema-version="0.1.0"

ENV PYTHONUNBUFFERED=1 \
    POETRY_HOME=/opt/poetry \
    PATH="$PATH:/opt/poetry/bin"

RUN curl -sSL https://install.python-poetry.org | python3 -

RUN echo '#!/usr/bin/env sh\n\nexport PATH="${PATH}:/opt/poetry/bin"' > /etc/profile.d/poetry.sh

COPY drone_poetry /bin/

ENTRYPOINT ["/bin/drone_poetry"]
