require 'spec_helper'
Awspec::Stub.load 'duplicated_resource'

describe 'Awspec::Type' do
  it 'DuplicatedResource' do
    expect { Awspec::Type::Vpc.new('my-vpc') }.to raise_error(
      Awspec::DuplicatedResourceTypeError,
      'Duplicated resource type my-vpc'
    )
  end
end
