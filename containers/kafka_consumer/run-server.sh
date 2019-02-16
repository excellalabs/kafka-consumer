#!/bin/bash

project_name="kafka-consumer"
jar_dir="/opt/${project_name}"
jar_path="${jar_dir}/${project_name}.jar"

/usr/bin/java -jar $jar_path
