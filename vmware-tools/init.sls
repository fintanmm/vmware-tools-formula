# Not sure if this is how this should be done.
include:
  - build-essential-formula.build-essential

gunzip-vmware:
    module.run:
        - name: archive.gunzip
        - gzipfile: {{ pillar.get('path', '/tmp/') }}{{ pillar.get('file', 'VMwareTools-8.3.12-493255.tar.gz') }}

tar-vmware:
    module.run:
        - name: archive.tar
        - options: xf
        # FIXME: take out tar file name
        - tarfile: {{ pillar.get('path', '/tmp/') }}VMwareTools-8.3.12-493255.tar
        - cwd: /tmp/

# extract-vmware:
#   archive:
#     - extracted
#     - name: /tmp/
#     - source: {{ pillar.get('path', '/tmp/') }}{{ pillar.get('file', 'VMwareTools-8.3.12-493255.tar.gz') }}
#     - source_hash: sha1=a3daed3dafa9ffe1fd517680708c0d30fbb9e11f
#     - tar_options: J
#     - archive_format: tar
#     - if_missing: /tmp/vmware-tools-distrib/

install-vmware-tools:
    cmd.run:
        - cwd: /tmp/vmware-tools-distrib/
        - name: ./vmware-install.pl -d

vmware-tools:
    service:
        - running
        - enable: True

