class Relation < ActiveRecord::Base
  belongs_to :article
  belongs_to :menu
end
