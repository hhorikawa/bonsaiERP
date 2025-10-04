# encoding: utf-8
# author: Boris Barroso
# email: boriscyber@gmail.com
class User < ApplicationRecord
  authenticates_with_sorcery!
  
  self.table_name = 'public.users'

  ROLES = %w(admin group other demo).freeze

  # Callbacks
  before_update :store_old_emails, if: :email_changed?

  ########################################
  # Relationships
  has_many :links, dependent: :destroy
  has_many :active_links, -> { where active: true }, inverse_of: :user, autosave: true,
           dependent: :destroy, class_name: 'Link'
  has_many :organisations, through: :active_links

  ########################################
  # Validations
  validates_email_format_of :email, message: I18n.t("errors.messages.user.email")
  validates :email, presence: true, uniqueness: {if: :email_changed?, message: I18n.t('errors.messages.email_taken')}

  with_options if: -> { new_record? || changes[:crypted_password] } do |u|
    u.validates :password, length: {within: PASSWORD_LENGTH..100 }
    u.validates :password, confirmation: true 
    u.validates :password_confirmation, presence: true 
  end

  # Scopes
  scope :active, -> { where(active: true) }

  # Delegations
  ########################################
  delegate :name, :currency, :address, :tenant, to: :organisation, prefix: true, allow_nil: true

  def to_s
    if first_name.present? || last_name.present?
      %Q(#{first_name} #{last_name}).strip
    else
      %Q(#{email})
    end
  end

  def tenant_link(tenant)
    active_links.where(tenant: tenant).first
  end

  def active_links?
    active_links.any?
  end

  # Updates the priviledges of a user
  def update_user_role(params)
    self.link.update(role: params[:rolname], active: params[:active_link])
  end

  def set_auth_token
    self.update_attribute(:auth_token, SecureRandom.urlsafe_base64(32))
  end

  def reset_auth_token
    self.update_attribute(:auth_token, '')
  end

  def set_confirmation_token
    self.confirmation_token = SecureRandom.urlsafe_base64(32)
  end

  
private

  def store_old_emails
      self.old_emails = [email_was] + old_emails
    end

end
