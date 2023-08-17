require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:request) %> do
  context 'with <%= name.underscore.pluralize %>' do
    let!(:<%= class_name %>) { Fabricate(:<%= class_name %>) }

    describe 'GET /<%= name.underscore.pluralize %>' do
      it 'should return the collections' do
        get(<%= name.underscore.pluralize %>_path)

        expect(response).to have_http_status(:ok)
        expect(response_json['data'].size).to eq(1)
        expect(response_json['data'].first).to have_id(<%= class_name %>.id)
      end
    end

    describe 'GET /<%= name.underscore.pluralize %>/<UUID>' do
      it do
        get(<%= class_name %>_path(<%= class_name %>.id))

        expect(response).to have_http_status(:ok)
        expect(response_json['data']).to have_id(<%= class_name %>.id)
      end
    end

    describe 'DELETE /<%= name.underscore.pluralize %>/<UUID>' do
      it 'should properly delete the resource' do
        expect do
          delete(<%= class_name %>_path(<%= class_name %>.id))
        end.to change(<%= class_name.capitalize %>, :count).by(-1)

        expect(response).to have_http_status(:no_content)
        expect(response.body).to be_blank
      end
    end

    describe 'PUT-PATCH /<%= name.underscore.pluralize %>/<UUID>' do
      let(:params) do
        { data: { attributes: param_attributes } }
      end

      context 'with valid params' do
        let(:param_attributes) do
          {
            # Fill out with valid fields
          }
        end

        it 'should update properly the resource' do
          expect do
            put(<%= class_name %>_path(<%= class_name %>.id), params: params)
          end.to change {
            <%= class_name %>.reload.name
          }.from(<%= class_name %>.name).to(param_attributes[:name])

          expect(response).to have_http_status(:ok)

          expect(response_json['data']).to have_id(<%= class_name %>.id)
        end
      end

      context 'with invalid params' do
        let(:param_attributes) do
          {
            # Fill out with valid fields
          }
        end

        it 'should return the error message' do
          expect {
            put(<%= class_name %>_path(<%= class_name %>.id), params: params)
          }.not_to change(<%= class_name %>, :name)

          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end
  end

  describe 'POST /<%= name.underscore.pluralize %>' do
    let(:params) do
      { data: { attributes: param_attributes } }
    end

    context 'with valid attributes' do
      let(:<%= class_name %>) { <%= class_name.capitalize %>.last }
      let(:param_attributes) do
        Fabricate.attributes_for(:<%= class_name %>)
      end

      it do
        expect do
          post(<%= name.underscore.pluralize %>_path, params: params)
        end.to change(<%= class_name.capitalize %>, :count).by(+1)

        expect(response).to have_http_status(:created)

        expect(response_json['data']).to have_id(<%= class_name %>.id)
      end
    end

    context 'with invalid attributes' do
      let(:param_attributes) do
        {
          # Fill out with valid fields
        }
      end

      it 'should return the error message' do
        expect do
          post(<%= name.underscore.pluralize %>_path, params: params)
        end.not_to change(<%= class_name.capitalize %>, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
<% end -%>
