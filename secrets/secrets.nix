let
  flappy = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCpXmB3zR8B5Q8I+p90ANcNZGIfvmtT6UfAoJ5tBms2C5xY/2vyI1loJ/cf7cFWBeI6dkkm1cJeajkJL/YBp6Ps7p4cKn3uppj6rtPlEdBH3E0A0GM+WTW4SYaeOHY5m7v/iDHq9XqBhpAXpJjvuLH+8nAwt1NJqbxn8MnUEe3s29jsc7OpSsMfDn+2lJGmvCkchJxh+BfbeEFjy2ikBeBT6s9ZeMSlv2Bsawucin2A7htS7+i7sPTKfDlgrlzit1fUTLdyvy0Eo0Nq7qDU7thbxmQhmV2h5Trfia6Imqqb2mv/SREPc1txaQy57MckKFHd3FvGpBJdW+hk1mNxwKp653MDpbtRMfkF1ss1mrwtzKz2Fxf+28xcYHacNmCsBm3v2VDK5Dvb3y1H2/uatrqFOjDnXEcw8fQDYfmmL5SBo+ryMf3AcdVo1iK1aq7evQtPQri3Mo1T9EQypW4qjuHzSXDfWItLcjANcDTcYmAnA+UsLAO6BpCh4O6GMRItATM=";
  shrexbox = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDRHYq/RRk6aNajLJwqHwNBsRgph43FdWY13K1aZCBl2imii7EuR56NE8Vla32how5hHAdsXmFDOsuX7+klcAzWhQwWskUqoKXqUYfr0nBgCaiawjaG+cGOeP124os3DKfpNOmxGGcdHtYyUnW0x4TvBtUNk+8OGbkLM7E/l3XZQ0YExNTHt2swd4jrNHliNGd3octeUR78hMogB16WUswkDZu8Py5DN9o4Q2FK/W6DfvcOdJtM+DCLfvyR9yqHS/Zyucpn+5G8E94UDCbRyZCaIylQn6boMhhUS5YAvftMaZMk2fbAFQwpEuZyvUiyKlY6z+TmQ0eHnVTLSv6zrSPmNrNC3zB84rZkHeOwLE0g6j25xrlW48l4JLzggpVNsNQYKhjJhgC8K9v8xnHtPHLhA6qqKsWDwdXE/bQQ+dCuJ2cRqJ4NwkUsNWrUmX+JbWcO3w7WSKSJpiYs78sjLYXGwveq/PntYQlcQvACtCn5x6ucPkqV0PNOtPmHQfVuyP0=";

  systems = [ flappy shrexbox ];

  yubikey-usbc = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPtqbcf79hftPjzRHZ3Vy/bGJTSYzdw9akVSzxI4WUyr";
  yubikey-usba = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOqqHUxxsUbO8rvzowMKuj/mRmp9zIe+yJMU7NNmqxkb";

  yubikeys = [ yubikey-usbc yubikey-usba ];
in {
  "flappy/syncthing-cert.age".publicKeys = yubikeys ++ [flappy];
  "flappy/syncthing-key.age".publicKeys = yubikeys ++ [flappy];

  "shrexbox/syncthing-cert.age".publicKeys = yubikeys ++ [shrexbox];
  "shrexbox/syncthing-key.age".publicKeys = yubikeys ++ [shrexbox];
}
