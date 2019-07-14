module Awspec::Helper
  module Finder
    module Codebuild
      def find_codebuild_project(id)
        projects = select_all_codebuild_projects.select do |project|
          project == id
        end
        projects.single_resource(id)
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
