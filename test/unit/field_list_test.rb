require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'FieldListTest' do
    it 'should parse hash field list' do
      fl = FieldList.new(
        {
          'projects' => 'id,name',
          'todos' => 'id,description'
        },
        ProjectSerializer
      )
      fl.fields_for(:projects).must_equal %w(id name)
      fl.fields_for(:todos).must_equal %w(id description)
    end
  end
end
