#!/bin/bash

container_name="nornir"
test_input_path="/home/paul/src/marclab/nornir/nornir-testdata"
test_output_path="/home/paul/src/marclab/nornir/test-output"
nornir_source_root="/home/paul/src/marclab/nornir"

output=$(docker ps --filter name=${container_name})
if [[ ! $output =~ $container_name ]]; then
    echo "$container_name container does not exist, starting."
    docker run --name $container_name -it -d --tmpfs /tmp --gpus all  --cap-add SYS_ADMIN --cap-add DAC_READ_SEARCH -v ${nornir_source_root}:/mnt/nornir -v ${test_input_path}:/mnt/testinput -v ${test_output_path}:/mnt/testoutput -e TESTINPUTPATH=/mnt/testinput -e TESTOUTPUTPATH=/mnt/testoutput nornir
fi

docker exec -it $container_name bash
