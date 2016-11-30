require 'spec_helper'

Awspec::Stub.load 'ecs_container_instance'

describe ecs_container_instance('arn:aws:ecs:us-east-1:012345678910:container-instance'\
                                '/f2756532-8f13-4d53-87c9-aed50dc94cd7') do
  it { should exist }
end
