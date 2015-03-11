class AddConstraintMaxDepth < ActiveRecord::Migration
  # Note: SQLite apparently does not have support for altering a table or adding constraints with CHECK (at least out of the box)
  # //TODO: Ensure that the depth of the tree is at the maximum 2
  #
  # def up
  #   execute "ALTER TABLE categories ADD CONSTRAINT `check_depth` CHECK (ancestry_depth IN ('0', '1', '2'))"
  # end
  #
  # def down
  #   execute "ALTER TABLE categories DROP CONSTRAINT `check_depth`"
  # end
end
