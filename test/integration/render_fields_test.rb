require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderFieldsTest' do
    it 'should match json hash for a project with fields specified' do
      JSON.parse(actual_project).must_equal expected_project
    end

    it 'should match json hash for a project with fields specified as hash' do
      JSON.parse(actual_project_field_hash).must_equal expected_project
    end

    it 'should match json hash for a project array with fields specified' do
      JSON.parse(actual_projects).must_equal expected_projects
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        options: { fields: 'name,description' }
      )
    end
    let(:actual_project_field_hash) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        options: { fields: { projects: 'name,description' } }
      )
    end
    let(:expected_project) do
      {
        'projects' => {
          'name' => 'First Project',
          'description' => 'The first project',
          'href' => 'http://example.com/projects/100',
          'links' => {
            'todolist' => '200',
            'tags' => ['10']
          }
        }
      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer,
        options: { fields: 'name,description' }
      )
    end
    let(:expected_projects) do
      {
        'projects' => [
          {
            'name' => 'First Project',
            'description' => 'The first project',
            'href' => 'http://example.com/projects/100',
            'links' => {
              'todolist' => '200',
              'tags' => ['10']
            }
          },
          {
            'name' => 'Second Project',
            'description' => 'The second project',
            'href' => 'http://example.com/projects/110',
            'links' => {
              'todolist' => '210',
              'tags' => ['20']
            }
          }
        ]
      }
    end
  end
end