include:
  - packages.zip
  - packages.openjdk8

sonar-download:
  cmd.run:
    - name: curl -L https://sonarsource.bintray.com/Distribution/sonarqube/sonarqube-5.6.6.zip -o /root/sonarqube-5.6.6.zip
    - creates: /root/sonarqube-5.6.6.zip

sonar-install:
  archive.extracted:
    - name: /opt/
    - source: /root/sonarqube-5.6.6.zip
    - archive_format: zip
    - if_missing: /opt/sonarqube-5.6.6
    - user: root
    - require:
      - cmd: sonar-download
      - pkg: unzip

sonar-config:
  file.managed:
    - name: /opt/sonarqube-5.6.6/conf/sonar.properties
    - source: salt://packages/sonarqube/files/sonar.properties
    - template: jinja
    - require:
      - archive: sonar-install

sonarqube-service:
  service.running:
    - name: sonar
    - enable: True
    - watch:
      - file: sonar-config
    - require:
      - file: sonar-service-file
      - archive: sonar-install
      - user: sonarqube

sonar-service-file:
  file.managed:
    - name: /etc/systemd/system/sonar.service
    - source: salt://packages/sonarqube/files/sonar.service
    - user: root
    - group: root
    - mode: 640

sonar-user:
  user:
    - present
    - fullname: Sonarqube user
    - name: sonarqube
    - require:
      - group: sonarqube
    - groups:
      - sonarqube

sonar-group:
  group:
    - present
    - name: sonarqube
