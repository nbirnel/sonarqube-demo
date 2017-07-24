postgres-package:
  pkg:
    - installed
    - name: postgresql-server

postgres-contrib-package:
  pkg:
    - installed
    - name: postgresql-contrib

postgres-service:
  service:
    - running
    - enable: True
    - name: postgresql
    - require:
      - pkg: postgres-package
