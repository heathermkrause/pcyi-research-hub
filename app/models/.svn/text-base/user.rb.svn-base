class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :excelsheets_attributes

  validates :name, :presence => {:message => "Name can't be blank"}
  # attr_accessible :title, :body

  has_many :documents
  has_many :excelsheets

  accepts_nested_attributes_for :excelsheets
end
