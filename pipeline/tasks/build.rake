desc 'Build Kafka Consumer image'
task :'build:ecs' do
  puts 'buikld docker image for kafka consumer'

  docker_repo = @keystore.retrieve('KAFKA_CONSUMER_ECR_REPO')
  docker_image = "#{docker_repo}/kafka-consumer:latest"
  docker.build_docker_image(docker_image, 'containers/kafka_consumer')
  docker.push_docker_image(docker_image)

  puts 'done!'
end
