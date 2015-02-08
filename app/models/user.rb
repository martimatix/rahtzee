# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  country         :string
#  gravatar_url    :string
#  about_me        :text
#  password_digest :string
#  is_admin        :boolean          default("false")
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_many :users
end
