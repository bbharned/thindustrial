class CreateCourseCategories < ActiveRecord::Migration
  def change
    create_table :course_categories do |t|
    	t.integer :course_id
    	t.integer :category_id
    end
  end
end
