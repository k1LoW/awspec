# copyright (c) 2025 Atlassian US, Inc.
require 'spec_helper'
Awspec::Stub.load 'backup_vault'

describe backup_vault('my-backup-vault') do
  it { should exist }
  it { should be_available }
  it { should be_locked }
  it { should_not be_airgapped }

  its(:locked) { should be true }
  its(:lock_date) { should be < (Time.now - 60*60*24*30) }
  its(:vault_state) { should eq "AVAILABLE" }
  its(:vault_type) { should eq "BACKUP_VAULT" }
  its(:min_retention_days) { should be 7 }
  its(:max_retention_days) { should be 35 }
  its(:lock_date) { should eq(Time.new(2024, 10, 4, 9, 00, 00, '+00:00')) }
  its(:encryption_key_arn) { should eq 'arn:aws:kms:us-west-2:111122223333:key/1234abcd-12ab-34cd-56ef-1234567890ab' }
  its(:number_of_recovery_points) { should be > 100 }
end

describe backup_vault('my-airgapped-vault') do
  it { should exist }
  it { should_not be_failed }
  it { should_not be_locked }
  it { should be_airgapped }

  its(:locked) { should be false }
  its(:creation_date) { should be > Time.new(2016, 4, 4, 9, 00, 00, '+00:00') }
  its(:vault_state) { should eq "AVAILABLE" }
  its(:vault_type) { should eq "LOGICALLY_AIR_GAPPED_BACKUP_VAULT" }
  its(:backup_vault_arn) { should match /:111122223333:/ }
  its(:backup_vault_arn) { should match /:us-west-2:/ }
  its(:number_of_recovery_points) { should be > 10 }
end
