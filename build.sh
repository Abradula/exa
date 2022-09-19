# Build zhil console
echo "\n\n"
echo "Building zhil console..."
echo "\n"
docker build -t joasjaphes/openhim:latest .
echo "\n"
echo "Pushing zhil console image to docker hub"
echo "\n"
docker push joasjaphes/openhim:latest
echo "\n\n\n"

# Build mediators
cd mediators
echo "Building mediators..."
for dir in *; do
    echo "Building "$dir" mediator..."
    echo "\n"
    docker build -t joasjaphes/"${dir}"-mediator:latest "${dir}"
    echo "\n"
    echo "Pushing ${dir} mediator image to docker hub"
    echo "\n"
    docker push joasjaphes/"$dir"-mediator:latest
    echo "\n\n"
done
