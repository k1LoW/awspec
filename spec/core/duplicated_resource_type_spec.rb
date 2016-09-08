require 'spec_helper'
Awspec::Stub.load 'duplicated_resource_type'

describe 'Awspec::Type' do
  it 'Duplicated resource type' do
    expect { Awspec::Type::Vpc.new('my-vpc').id }.to raise_error(
      Awspec::DuplicatedResourceTypeError,
      'Duplicated resource type my-vpc'
    )
  end
end
