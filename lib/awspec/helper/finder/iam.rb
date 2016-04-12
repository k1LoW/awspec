module Awspec::Helper
  module Finder
    module Iam
      # find_iam_user, find_iam_group find_iam_role find_iam_policy
      role_types = %w(user group role policy)
      role_types.each do |type|
        define_method 'find_iam_' + type do |*args|
          id = args.first
          selected = []
          res = iam_client.method('list_' + type.pluralize).call
          loop do
            selected += res[type.pluralize].select do |u|
              u[type + '_name'] == id || u[type + '_id'] == id || u.arn == id
            end
            (res.next_page? && res = res.next_page) || break
          end

          selected.single_resource(id)
        end
      end

      def select_policy_evaluation_results(policy_arn, action_name, resource_arn = nil, context_entries = nil)
        options = {
          policy_source_arn: policy_arn,
          action_names: [action_name]
        }
        options[:resource_arns] = [resource_arn] if resource_arn
        options[:context_entries] = context_entries if context_entries

        res = iam_client.simulate_principal_policy(options)
        res.evaluation_results
      end

      def select_iam_group_by_user_name(user_name)
        res = iam_client.list_groups_for_user({
                                                user_name: user_name
                                              })
        res.groups
      end

      %w(user group role).each do |type|
        define_method 'select_iam_policy_by_' + type + '_name' do |name|
          res = iam_client.method('list_attached_' + type + '_policies').call({
                                                                                (type + '_name').to_sym => name
                                                                              })
          res.attached_policies
        end

        define_method 'select_inline_policy_by_' + type + '_name' do |name|
          res = iam_client.method('list_' + type + '_policies').call({
                                                                       (type + '_name').to_sym => name
                                                                     })
          res.policy_names
        end
      end

      def select_all_attached_policies
        selected = []
        res = iam_client.list_policies

        loop do
          selected += res.policies.select { |p| p.attachment_count > 0 }
          (res.next_page? && res = res.next_page) || break
        end

        selected
      end

      def select_attached_entities(policy_id)
        policy = find_iam_policy(policy_id)
        iam_client.list_entities_for_policy(policy_arn: policy[:arn])
      end

      def select_attached_users(policy_id)
        entities = select_attached_entities(policy_id)
        entities.policy_users
      end

      def select_attached_groups(policy_id)
        entities = select_attached_entities(policy_id)
        entities.policy_groups
      end

      def select_attached_roles(policy_id)
        entities = select_attached_entities(policy_id)
        entities.policy_roles
      end

      def select_all_iam_users
        iam_client.list_users.map do |responce|
          responce.users
        end.flatten
      end

      def select_all_iam_groups
        iam_client.list_groups.map do |responce|
          responce.groups
        end.flatten
      end

      def select_all_iam_roles
        iam_client.list_roles.map do |responce|
          responce.roles
        end.flatten
      end
    end
  end
end
