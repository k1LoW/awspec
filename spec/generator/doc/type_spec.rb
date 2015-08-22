require 'spec_helper'

types = Awspec::Helper::Type::TYPES
types.delete('base')
types.each do |type|
  describe 'Resource Type' + type do
    let(:generator) { eval "Awspec::Generator::Doc::Type::#{type.to_camel_case}.new" }
    it 'generate doc' do
      generated = generator.generate_doc
      expect(generated).to include(type)
      expect(generated).to include('exist')
    end
  end
end
