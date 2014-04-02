# Not sure if this is how this should be done.
include:
  - build-essential

vmware:
    file.copy:
        # - unless: vmware-tools
        - name: /tmp/VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz
        - source: file:///{{ salt['pillar.get']('vmware:path') }}VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz
        - source_hash: {{ salt['pillar.get']('vmware:source_hash') }}
        - makedirs: true

extract-vmware:
    module.run:
        - name: archive.tar
        - options: zxf
        - tarfile: /tmp/VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz
        - dest: /tmp/

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

