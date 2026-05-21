ActiveRecord::Schema.define do
  create_table :accounts, force: true do |t|
    t.string :name
    t.string :email
    t.timestamps
  end

  create_table :tags, force: true do |t|
    t.string :name
    t.timestamps
  end

  create_table :articles, force: true do |t|
    t.string :title
    t.text :body
    t.boolean :published
    t.integer :account_id
    t.timestamps
  end

  create_table :articles_tags, force: true, id: false do |t|
    t.integer :article_id
    t.integer :tag_id
  end
end
