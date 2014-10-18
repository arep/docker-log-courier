#Log-courier, replacement for logstash-forwarder
There are som issues with logstash-forwarder, and log-courier has many improvements over it.

Use this docker container to easily compile a .deb package of log-courier

## Create deb package of log-courier

Run this command to get your deb package for the latest log-courier:

    docker run --rm -v $(pwd):/target arep/log-courier
    
log-courier can be found here: [log-courier github] 


[log-courier github]: https://github.com/driskell/log-courier
