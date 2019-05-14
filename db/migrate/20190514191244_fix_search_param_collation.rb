class FixSearchParamCollation < ActiveRecord::Migration[5.1]
  def change
    execute("ALTER TABLE searches CHARACTER SET utf8 COLLATE utf8_unicode_ci")
    execute("ALTER TABLE searches CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci")
  end
end
