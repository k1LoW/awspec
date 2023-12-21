# frozen_string_literal: true

def describe_parameters_response(context)
  next_token = 'eyJOZXh0VG9rZW4iOiBudWxsLCAiYm90b190cnVuY2F0ZV9hbW91bnQiOiAxfQ=='
  if context.params[:next_token] == next_token
    {
      parameters: [
        {
          name: 'my-parameter',
          type: 'SecureString',
          key_id: 'alias/aws/ssm',
          description: 'Some description',
          version: 1
        }
      ],
      next_token: nil
    }
  else
    {
      parameters: [],
      next_token: next_token
    }
  end
end

Aws.config[:ssm] = {
  stub_responses: {
    describe_parameters: ->(context) { describe_parameters_response(context) }
  }
}
