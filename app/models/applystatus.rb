class Applystatus < ApplicationRecord
  belongs_to :user
  belongs_to :job
end
