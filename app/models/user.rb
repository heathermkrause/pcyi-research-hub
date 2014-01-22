class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :excelsheets_attributes, :admin

  validates_presence_of :name
  validates_format_of :name, :with => /^[^0-9`!@#\$%\^&*+_=]+$/ , :message => "Name is invalid"

  validates_length_of :name, :maximum => 100, :message=> "less than %d if you don't mind"
  # attr_accessible :title, :body

  has_many :documents,:dependent=>:destroy
  has_many :excelsheets,:dependent=>:destroy

  accepts_nested_attributes_for :excelsheets
end
