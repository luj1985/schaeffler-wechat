class PageRelation < ActiveRecord::Base
  belongs_to :page
  belongs_to :menu
end
