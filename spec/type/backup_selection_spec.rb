# copyright (c) 2025 Atlassian US, Inc.
require 'spec_helper'
Awspec::Stub.load 'backup_selection'

describe backup_selection('my-backup-selection') do
  it { should exist }

  it { should belong_to_backup_plan('fff3e784-1a0f-4e7c-8fe9-ba69825f7c00') }
  it { should belong_to_backup_plan('arn:aws:backup:us-west-2:111122223333:backup-plan:fff3e784-1a0f-4e7c-8fe9-ba69825f7c00') }
  it { should belong_to_backup_plan('my-backup-plan') }

  its(:selection_id) { should eq '01dfb41f-c3ca-4b45-91e7-63ef43fe7231' }
  its(:backup_plan_id) { should eq 'fff3e784-1a0f-4e7c-8fe9-ba69825f7c00' }
  its(:creation_date) { should be > Time.new(2016, 4, 4, 4, 00, 00, '+00:00') }
  its(:iam_role_arn) { should match(/111122223333/).and(match(/my-backup-service-role/)) }
  end
