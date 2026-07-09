let
  flappy = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpXmB3zR8B5Q8I+p90ANcNZGIfvmtT6UfAoJ5tBms2C5xY/2vyI1loJ/cf7cFWBeI6dkkm1cJeajkJL/YBp6Ps7p4cKn3uppj6rtPlEdBH3E0A0GM+WTW4SYaeOHY5m7v/iDHq9XqBhpAXpJjvuLH+8nAwt1NJqbxn8MnUEe3s29jsc7OpSsMfDn+2lJGmvCkchJxh+BfbeEFjy2ikBeBT6s9ZeMSlv2Bsawucin2A7htS7+i7sPTKfDlgrlzit1fUTLdyvy0Eo0Nq7qDU7thbxmQhmV2h5Trfia6Imqqb2mv/SREPc1txaQy57MckKFHd3FvGpBJdW+hk1mNxwKp653MDpbtRMfkF1ss1mrwtzKz2Fxf+28xcYHacNmCsBm3v2VDK5Dvb3y1H2/uatrqFOjDnXEcw8fQDYfmmL5SBo+ryMf3AcdVo1iK1aq7evQtPQri3Mo1T9EQypW4qjuHzSXDfWItLcjANcDTcYmAnA+UsLAO6BpCh4O6GMRItATM=";

  systems = [ flappy ];

  yubikey-usbc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtqbcf79hftPjzRHZ3Vy/bGJTSYzdw9akVSzxI4WUyr";

  yubikeys = [ yubikey-usbc ];
in {
  "flappy/syncthing-cert.age".publicKeys = yubikeys ++ [flappy];
  "flappy/syncthing-key.age".publicKeys = yubikeys ++ [flappy];
}
