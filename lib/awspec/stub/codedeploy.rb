Aws.config[:codedeploy] = {
  stub_responses: {
    get_application: {
      application: {
        application_id: 'd3be67e5-e7l6-457b-946b-7a457EXAMPLE',
        application_name: 'my-codedeploy',
        create_time: Time.at(1_446_229_001),
        linked_to_git_hub: false
      }
    }
  }
}
