desc 'Deploy RDS instance'
task :'deploy:rds' do
  puts 'deploy RDS cloudformation template'
  stack_name = 'KAFKA-CONSUMER-RDS'

  parameters = {
    'Vpc' => @keystore.retrieve('VPC_ID'),
    'DbSubnetGroupId' => @keystore.retrieve('PUBLIC_RDS_SUBNET_GROUP_ID'),
    'DbInstanceIdentifier' => stack_name,
    'DbSnapshotIdentifier' => stack_name,
    'DbUsername' => @keystore.retrieve('KAFKA_CONSUMER_RDS_USER'),
    'DbPassword' => @keystore.retrieve('KAFKA_CONSUMER_RDS_PASSWORD'),
    'DbInstanceClass' => 'db.t2.micro',
    'DbAllocatedStorage' => '20',
    'MultiAzEnabled' => 'false',
    'DbParameterGroup' => 'default.postgres9.6'
  }

  @cloudformation.deploy_stack(
    stack_name,
    parameters,
    'provisioning/rds.yml'
  )

  @cloudformation.stack_outputs(stack_name)

  @keystore.store('KAFKA_CONSUMER_RDS_HOST', stack_outputs['DbHost'])
  @keystore.store('KAFKA_CONSUMER_RDS_PORT', stack_outputs['DbPort'])
  puts "db host: #{stack_outputs['DbHost']}"
  puts "db port: #{stack_outputs['DbPort']}"
end

desc 'Deploy Kafka Consumer ECS'
task :'deploy:ecs' do
  puts 'deploy ecs cloudformation template'

  puts 'done!'
end
