FROM python

LABEL maintainer="Carson Gee <x@carsongee.com>" \
  org.label-schema.name="Drone Poetry" \
  org.label-schema.vendor="Carson Gee" \
  org.label-schema.schema-version="0.1.0"

ENV PYTHONUNBUFFERED 1
RUN curl -sSL https://install.python-poetry.org | python3 -

COPY drone_poetry /bin/

ENTRYPOINT ["/bin/drone_poetry"]
