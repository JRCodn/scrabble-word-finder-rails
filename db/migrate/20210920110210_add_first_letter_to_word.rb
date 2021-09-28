class AddFirstLetterToWord < ActiveRecord::Migration[6.0]
  def change
    add_column :words, :firstLetter, :string
  end
end
