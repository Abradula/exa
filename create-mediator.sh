echo "Mediator name:"
read NAME;
echo "Mediator description"
read DESCRIPTION
echo "Mediator host name (This is a docker container name for this mediator):"
read HOST

if [ -z ${HOST} ]; then
    echo "Please provide mediator name"
else
    mkdir mediators/${HOST}
    echo `{ "Mediators" : [{
            "urn": "urn:mediator:${HOST}",
            "version": "1.0.0",
            "name": "${NAME}",
            "description": "${DESCRIPTION}",
            "endpoints": [
                {
                    "name": "${NAME}",
                    "host": "${HOST}",
                    "path": "/",
                    "port": 3000,
                    "primary": true,
                    "type": "http"
                }
            ]
        }]}` > mediators/${1}/mediator.conf.json
    # nest new mediators/${1} --skip-git
fi
