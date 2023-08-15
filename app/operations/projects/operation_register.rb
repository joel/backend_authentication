# frozen_string_literal: true

module Projects
  class OperationRegister
    extend Dry::Container::Mixin

    namespace "projects" do
      register "validate" do
        Projects::Validate.new
      end

      register "instance" do
        Projects::Instance.new
      end

      register "update" do
        Projects::Update.new
      end
    end
  end
end
