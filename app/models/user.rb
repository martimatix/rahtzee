# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  username     :string
#  country      :string
#  gravatar_url :string
#  about_me     :text
#  created_at   :datetime
#  updated_at   :datetime
#

class User < ActiveRecord::Base
  has_many :users
end
