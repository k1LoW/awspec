require 'spec_helper'
Awspec::Stub.load 'efs'

describe efs('my-efs') do
  it { should exist }
  its(:number_of_mount_targets) { should eq 1 }
  its(:life_cycle_state) { should eq 'available' }
  its(:performance_mode) { should eq 'generalPurpose' }
  it { should have_tag('Name').value('my-efs') }
  it { should have_tag('my-key').value('my-value') }
end
