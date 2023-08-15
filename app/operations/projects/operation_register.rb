# frozen_string_literal: true

module Projects
  class OperationRegister
    extend Dry::Container::Mixin

    namespace "projects" do
      register "validate" do
        Projects::Validate.new
      end

      register "create" do
        Projects::Create.new
      end
    end
  end
end
