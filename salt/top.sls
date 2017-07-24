base:
  'role:sonarqube':
    - match: grain
    - packages.openjdk8
    - packages.postgres
    - packages.tmux
    - packages.vim
    - packages.wget
    - packages.zip

  'role:salt':
    - match: grain
    - packages.tmux
    - packages.salt-master
    - packages.vim


