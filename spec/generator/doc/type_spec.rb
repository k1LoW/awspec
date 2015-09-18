require 'spec_helper'

describe 'Awspec::Generator::Doc::Type' do
  it 'generate_doc outout should be same as doc/resource_type.md' do
    generated = Awspec::Generator::Doc::Type.generate_doc
    doc = File.read(File.dirname(__FILE__) + '/../../../doc/resource_types.md').sub(/\n*\z/, '')
    expect(generated).to eq doc
  end
end

types = Awspec::Helper::Type::TYPES
types.delete('base')
types.each do |type|
  describe 'Resource Type ' + type do
    let(:generator) { eval "Awspec::Generator::Doc::Type::#{type.camelize}.new" }
    it 'should generate doc' do
      generated = generator.generate_doc
      expect(generated).to include(type)
      expect(generated).to include('exist')
    end
  end
end
