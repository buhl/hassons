ARG BUILD_FROM=hassioaddons/base:7.2.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}


RUN echo $(whoami)
# Copy root filesystem
COPY rootfs /


# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apk update
# Setup base
# hadolint ignore=DL3003
RUN apk add --no-cache --virtual .build-dependencies \
        build-base=0.5-r1 \
        libffi-dev=3.2.1-r6 \
        python3-dev=3.8.2-r0
RUN apk add -v -v --no-cache python3=3.8.2-r0
RUN python3 -m pip install -U pip
RUN python3 -m pip install radicale[bcrypt]==3.0.1
RUN apk del --no-cache --purge .build-dependencies
RUN rm -fr /root/.cache
#RUN echo $(whoami) > /userinfo


EXPOSE 5232

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Radical" \
    io.hass.description="Free and Open-Source CalDAV and CardDAV Server" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Morten <221842+buhl@users.noreply.github.com>" \
    org.opencontainers.image.title="Radical" \
    org.opencontainers.image.description="Free and Open-Source CalDAV and CardDAV Server" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Morten <221842+buhl@users.noreply.github.com>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/buhl/ha-addons/radical" \
    org.opencontainers.image.documentation="https://github.com/buhl/ha-addons/radical/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
