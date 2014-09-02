class User < ActiveRecord::Base
	validates :stack_id, presence: true, uniqueness: true
end
