require 'spec_helper'

describe 'Awspec::Generator::Doc::Ec2' do
  let(:generator) { Awspec::Generator::Doc::Ec2.new }
  it 'generate doc' do
    generated = generator.generate_doc
    expect(generated).to include('ec2')
    expect(generated).to include('have_eip')
    expect(generated).to include('belong_to_subnet')
  end
end
