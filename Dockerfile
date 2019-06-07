FROM sentry:9.1-onbuild

COPY kombo-3.0.35-redis-patch.py /

RUN \
    EXPECTED_KOMBU_VERSION="3.0.35" && \
    FOUND_KOMBU_VERSION="$(pip show kombu | grep Version | awk '{ print $2}')" && \
    if [ "${FOUND_KOMBU_VERSION}" != "${EXPECTED_KOMBU_VERSION}" ]; then echo "Bad kombu version: ${FOUND_KOMBU_VERSION}. govau redis patch expected version: ${EXPECTED_KOMBU_VERSION}"; false; fi && \
    cp /kombo-3.0.35-redis-patch.py /usr/local/lib/python2.7/site-packages/kombu/transport/redis.py