# frozen_string_literal: true

require 'spec_helper'

describe 'Awspec::Generator::Spec::Efs' do
  before do
    Awspec::Stub.load 'efs'
  end
  let(:efs) { Awspec::Generator::Spec::Efs.new }
  it 'generate_all generate spec' do
    spec = <<-'EOF'
describe efs('my-efs') do
  it { should exist }
  its(:number_of_mount_targets) { should eq 1 }
  its(:life_cycle_state) { should eq 'available' }
  its(:performance_mode) { should eq 'generalPurpose' }
end
EOF
    expect(efs.generate_all.to_s.gsub(/\n/, "\n")).to eq spec
  end
end
