class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, null: false, foreign_key: true # user:references는 두가지 일을 한다. 하나는 foreign key로 user_id:integer를 만들고 인덱스도 동시에 생성한다.

      t.timestamps
    end
  end
end
