# frozen_string_literal: true

module Awspec::Helper
  module Finder
    module Codebuild
      def find_codebuild_project(id)
        res = codebuild_client.batch_get_projects({ names: [id] })
        res.projects.single_resource(id)
      end

      def select_all_codebuild_projects
        req = {}
        projects = []
        loop do
          res = codebuild_client.list_projects(req)
          projects.push(*res.projects)
          break if res.next_token.nil?

          req[:next_token] = res.next_token
        end
        projects
      end
    end
  end
end
