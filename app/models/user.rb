class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    before_save :default_role

    has_many :rooms
    has_many :bookings
    has_many :reviews
    belongs_to :role

    validates_presence_of :first_name, :last_name, :username, :email, :mobile
    validates_uniqueness_of :email, :username, :mobile
    validates_numericality_of :mobile
    validates_length_of :mobile, is: 10

    def role?(role)
        self.role.name == role
    end

    def default_role
  		if self.role == nil
        	self.role_id = Role.last.id
		end
    end 
end
