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

postgres-data-dir:
  postgres_initdb.present:
    - name /var/lib/pgsql/data
    - auth: password
    - user: postgres
    - password={{ pillar['postgres']['password'] }}
    - encoding: UTF8
    - locale: C
    - runas: postgres
