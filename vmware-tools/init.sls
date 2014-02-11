# Not sure if this is how this should be done.
include:
  - build-essential

gunzip-vmware:
    module.run:
        - name: archive.gunzip
        - gzipfile: {{ salt['pillar.get']('vmware:path') }}VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz

tar-vmware:
    module.run:
        - name: archive.tar
        - options: xf
        - tarfile: {{ salt['pillar.get']('vmware:path') }}VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz
        - cwd: /tmp/

# extract-vmware:
#   archive:
#     - extracted
#     - name: /tmp/
#     - source: {{ salt['pillar.get']('vmware:path') }}VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz
#     - source_hash: {{ salt['pillar.get']('vmware:source_hash') }}
#     - tar_options: J
#     - archive_format: tar
#     - if_missing: /tmp/vmware-tools-distrib/

install-vmware-tools:
    cmd.run:
        - cwd: /tmp/vmware-tools-distrib/
        # TODO: Should be quiet
        - quiet: True
        - name: ./vmware-install.pl -d 2>&1

# TODO: Remove build-essentials
vmware-tools:
    service:
        - running
        - enable: True
        - require:
          - sls: build-essential.absent

