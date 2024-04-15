FROM steamcmd/steamcmd:ubuntu-jammy

COPY rootfs /

ENTRYPOINT ["/usr/local/bin/entry.sh"]

CMD ["/usr/local/bin/pz.sh"]
