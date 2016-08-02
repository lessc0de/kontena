require_relative 'common'

module Kontena::Cli::Stacks
  class RemoveCommand < Clamp::Command
    include Kontena::Cli::Common
    include Kontena::Cli::GridOptions
    include Common

    parameter "NAME", "Service name"
    option "--force", :flag, "Force remove", default: false, attribute_name: :forced

    def execute
      require_api_url
      token = require_token

      confirm_command(name) unless forced?
      remove_stack(token, name)
    end

    def remove_stack(token, name)
      client(token).delete("stacks/#{current_grid}/#{name}")
    end
  end
end