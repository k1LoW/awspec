# frozen_string_literal: true

require 'spec_helper'

describe 'shared_context region' do
  before do
    Aws.config[:region] = 'ap-northeast-1'
  end

  context 'use default region' do
    it 'used ap-northeast-1' do
      expect(Aws.config[:region]).to eq 'ap-northeast-1'
    end
  end

  context 'use custom region', region: 'us-east-1' do
    it 'used us-east-1' do
      expect(Aws.config[:region]).to eq 'us-east-1'
    end
  end
end
