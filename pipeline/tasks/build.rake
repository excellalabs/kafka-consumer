desc 'Build Kafka Consumer image'
task :'build:ecs' do
  puts 'buikld docker image for kafka consumer'

  system('$(aws ecr get-login --no-include-email --region us-east-1)')

  docker_repo = @keystore.retrieve('KAFKA_CONSUMER_ECR_REPO')
  docker_image = "#{docker_repo}/kafka-consumer:latest"
  @docker.build_docker_image(docker_image, 'containers/kafka_consumer')
  @docker.push_docker_image(docker_image)

  puts 'done!'
end
