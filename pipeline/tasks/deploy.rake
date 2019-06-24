# rubocop:disable Metrics/BlockLength
desc 'Deploy RDS instance'
task :'deploy:rds' do
  puts 'deploy RDS cloudformation template'
  stack_name = 'XSP-KAFKA-CONSUMER-RDS'

  parameters = {
    'Vpc' => @keystore.retrieve('VPC_ID'),
    'DbSubnetGroupId' => @keystore.retrieve('DB_SUBNET_ID'),
    'DbInstanceIdentifier' => stack_name,
    'DbSnapshotIdentifier' => stack_name,
    'DbUsername' => @keystore.retrieve('KAFKA_CONSUMER_RDS_USER'),
    'DbPassword' => @keystore.retrieve('KAFKA_CONSUMER_RDS_PASSWORD'),
    'DbInstanceClass' => 'db.t2.micro',
    'DbAllocatedStorage' => '10',
    'MultiAzEnabled' => 'false',
    'DbParameterGroup' => 'default.postgres11'
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/rds.yml'
  )

  outputs = @cloudformation.stack_outputs(stack_name)

  @keystore.store('KAFKA_CONSUMER_RDS_HOST', outputs['DbHost'])
  @keystore.store('KAFKA_CONSUMER_RDS_PORT', outputs['DbPort'])
  puts "db host: #{outputs['DbHost']}"
  puts "db port: #{outputs['DbPort']}"
end

desc 'Deploy Kafka Consumer ECS'
task :'deploy:ecs' do
  puts 'deploy ecs cloudformation template'

  stack_name = 'XSP-KAFKA-CONSUMER-ECS'
  service_name = 'kafka-consumer'
  ecs_cluster = @keystore.retrieve('INTERNAL_ECS_CLUSTER')
  private_subnets = get_subnets('private')

  private_sg = @keystore.retrieve('PRIVATE_SECURITY_GROUP')
  kafka_url = @keystore.retrieve('KAFKA_BOOTSTRAP_SERVERS')
  db_host = @keystore.retrieve('KAFKA_CONSUMER_RDS_HOST')
  db_port = @keystore.retrieve('KAFKA_CONSUMER_RDS_PORT')
  db_user = @keystore.retrieve('KAFKA_CONSUMER_RDS_USER')
  db_password = @keystore.retrieve('KAFKA_CONSUMER_RDS_PASSWORD')
  db_name = 'postgres'

  parameters = {
    'Cluster' => ecs_cluster,
    'ServiceName' => service_name,
    'VPC' => @keystore.retrieve('VPC_ID'),
    'PrivateSubnetIds' => private_subnets,
    'EcsSecurityGroup' => private_sg,
    'Image' => @docker_image,
    'Port' => @port,
    'KafkaBootstrapServer' => kafka_url,
    'DbHost' => db_host,
    'DbPort' => db_port,
    'DbUser' => db_user,
    'DbPassword' => db_password,
    'DbName' => db_name
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/ecs.yml',
    ['CAPABILITY_NAMED_IAM']
  )

  puts 'done!'
end
# rubocop:enable Metrics/BlockLength
