#!/bin/bash

project_name="kafka-consumer"
jar_dir="/opt/${project_name}"
jar_path="${jar_dir}/${project_name}.jar"

java -javaagent:/opt/kafka-consumer/jmx_prometheus_javaagent.jar=7071:/opt/kafka-consumer/prometheus-config.yml -jar $jar_path
