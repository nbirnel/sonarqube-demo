base:
  'role:sonarqube':
    - match.grain
    - packages.tmux

  'role:salt':
    - match.grain
    - packages.tmux
    - packages.salt-master


