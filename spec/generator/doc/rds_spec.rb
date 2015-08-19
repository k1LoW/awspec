require 'spec_helper'

describe 'Awspec::Generator::Doc::Rds' do
  let(:generator) { Awspec::Generator::Doc::Rds.new }
  it 'generate doc' do
    generated = generator.generate_doc
    expect(generated).to include('rds')
    expect(generated).to include('belong_to_subnet')
  end
end
