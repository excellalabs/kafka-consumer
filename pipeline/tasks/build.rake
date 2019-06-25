desc 'Build Kafka Consumer image'
task :'build:ecs' do
  puts 'buikld docker image for kafka consumer'

  system('$(aws ecr get-login --no-include-email --region us-east-1)')

  # create the ecr repo if not exists
  system("ws ecr describe-repositories --region us-east-1 \
    --repository-names #{@ecs_repo_name} || \
    aws ecr create-repository --region us-east-1 \
    --repository-name #{@ecs_repo_name}")

  @docker.build_docker_image(@docker_image, 'containers/kafka_consumer')
  @docker.push_docker_image(@docker_image)

  puts 'done!'
end

desc 'Assemble binary and copy for docker build'
task assemble: ['gradle:build'] do
  sh 'cp ./build/'\
     'libs/kafka-consumer-*.jar ' \
     'containers/kafka_consumer/' \
     'kafka-consumer.jar' \
     || raise('task failed - jar not found')
end
