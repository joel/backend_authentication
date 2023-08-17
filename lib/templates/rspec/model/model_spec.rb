require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:model) %> do
  let(:<%= class_name.underscore %>) { described_class.new attributes }

  context 'valid_attributes' do
    let(:valid_attributes) do
      Fabricate.attributes_for(:<%= class_name.underscore %>)
    end
    let(:attributes) { valid_attributes }
    it { expect(<%= class_name.underscore %>).to be_valid }
  end

  context 'invalid_attributes' do
    let(:invalid_attributes) do
      { <%= attributes.first.name %>: nil }
    end
    let(:attributes) { invalid_attributes }
    it do
      expect(<%= class_name.underscore %>).not_to be_valid
      expect(<%= class_name.underscore %>.errors.messages).to eql(<%= attributes.first.name %>: ["can't be blank"])
    end
  end
end
<% end -%>
