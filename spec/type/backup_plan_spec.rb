# copyright (c) 2025 Atlassian US, Inc.
require 'spec_helper'
Awspec::Stub.load 'backup_plan'

describe backup_plan('my-backup-plan') do
  it { should exist }

  its(:backup_plan_arn) { should match /us-west-2:111122223333/ }
  its(:backup_plan_id) { should eq 'fff3e784-1a0f-4e7c-8fe9-ba69825f7c00' }
  its(:creation_date) { should be < Time.new(2024, 4, 4, 9, 00, 00, '+00:00') }
  its(:deletion_date) { should be nil }
  its(:version_id) { should eq 'disFW7K0dOAjTaMWKYlhEyScjBhmi5kKGf7BrY7i1BG8F8wB' }
  its(:last_execution_date) { should be > Time.new(2016, 4, 4, 9, 00, 00, '+00:00') }
end
