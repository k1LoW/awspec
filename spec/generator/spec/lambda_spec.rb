require 'spec_helper'

describe Awspec::Generator::Spec::Lambda do
  before do
    Awspec::Stub.load 'lambda'
  end
  let(:lambda) { Awspec::Generator::Spec::Lambda.new }
  it 'generates spec' do
    spec = <<-'EOF'

describe lambda('my-lambda-function-name') do
  it { should exist }
  its(:description) { should eq 'My Lambda Function' }
  its(:runtime) { should eq 'python2.7' }
  its(:handler) { should eq 'lambda_function.lambda_handler' }
  its(:code_size) { should eq 1234 }
  its(:timeout) { should eq 5 }
  its(:memory_size) { should eq 256 }
end
EOF
    expect(lambda.generate_all.to_s).to eq spec
  end
end
