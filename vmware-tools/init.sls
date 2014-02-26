# Not sure if this is how this should be done.
include:
  - build-essential

extract-vmware:
    module.run:
        - name: archive.tar
        - options: zxf
        - tarfile: {{ salt['pillar.get']('vmware:path') }}VMwareTools-{{ salt['pillar.get']('vmware:version') }}.tar.gz
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

