sonar-postgres-user:
  postgres_user:
    - present
    - name: sonarqube

sonar-postgres-schema:
  postgres_schema:
    - present
    - name: sonarqube
    - owner: sonarqube
    - db_user: sonarqube
    - db_password={{ pillar['sonarqube']['postgres_password'] }}
