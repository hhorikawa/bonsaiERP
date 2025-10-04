class UserWithRole
  attr_reader :user, :organisation

  delegate :role, :master_account?, to: :link
  delegate :email, :id, to: :user

  def initialize(user, organisation)
    raise TypeError, '@user must be type User' if !user.is_a?(User)
    raise TypeError, '@organisation must be type Organisation'  if !organisation.is_a?(Organisation)
    
    @user = user
    @organisation = organisation
  end

  def link
    @link ||= user.links.org_links(organisation.id).first
  end

  ########################################
  # Methods
  User::ROLES.each do |_role|
    define_method :"is_#{_role}?" do
      link.role == _role
    end
  end
end
