# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Doc::Type' do
  it 'generate_doc output should be the same as doc/resource_types.md' do
    generated = Awspec::Generator::Doc::Type.generate_doc
    doc = File.read("#{File.dirname(__FILE__)}/../../../doc/resource_types.md").sub(/\n*\z/, '')
    expect(generated).to eq doc
  end
end

types = Awspec::Helper::Type::TYPES
types.delete('base')
types.each do |type|
  describe "Resource Type #{type}" do
    let(:generator) { eval "Awspec::Generator::Doc::Type::#{type.camelize}.new" }
    it 'should generate doc' do
      generated = generator.generate_doc
      expect(generated).to include(type)
    end
  end
end
