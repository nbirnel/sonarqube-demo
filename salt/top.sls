base:
  'role:sonarqube':
    - match: grain
    - packages.tmux
    - packages.vim

  'role:salt':
    - match: grain
    - packages.tmux
    - packages.salt-master
    - packages.vim


