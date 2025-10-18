# frozen_string_literal: true

require 'spec_helper'
Awspec::Stub.load 'backup_plan'

describe backup_plan('my-backup-plan') do
  it { should exist }

  its(:backup_plan_arn) { should match(/us-west-2:111122223333/) }
  its(:backup_plan_id) { should eq 'fff3e784-1a0f-4e7c-8fe9-ba69825f7c00' }
  its(:creation_date) { should be < Time.new(2024, 4, 4, 9, 00, 00, '+00:00') }
  its(:deletion_date) { should be nil }
  its(:version_id) { should eq 'disFW7K0dOAjTaMWKYlhEyScjBhmi5kKGf7BrY7i1BG8F8wB' }
  its(:last_execution_date) { should be > Time.new(2016, 4, 4, 9, 00, 00, '+00:00') }

  it { should have_plan_rule('my-daily-backup') }
  it { should have_plan_rule('my-daily-backup').lifecycle('{"delete_after_days": 7}') }
  it { should_not have_plan_rule('my-daily-backup').lifecycle('{"delete_after_days": 30}') }

  it { should_not have_plan_rule('non-existing-backup') }

  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4') }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').target_backup_vault_name('Default') }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').schedule_expression('cron(30 * ? * * *)') }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').start_window_minutes(60) }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').completion_window_minutes(1440) }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').lifecycle('{"delete_after_days":30}') }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').enable_continuous_backup(false) }
  it { should have_plan_rule('febe7fd4-c95f-4d26-b502-97adf2fd0cf4').schedule_expression_timezone('Etc/UTC') }\
end
