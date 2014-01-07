class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :youtube_key
      t.float :rating
      t.references :user, index: true
      t.attachment :song

      t.timestamps
    end
  end
end
