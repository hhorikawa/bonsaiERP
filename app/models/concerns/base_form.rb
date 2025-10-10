
# author: Boris Barroso
# email: boriscyber@gmail.com

=begin
ActiveRecord::Base でないクラスのインスタンスで、Validations の機能を使う。

module ActiveModel::API = ActiveModel::AttributeAssignment +
                          ActiveModel::Validations + 
                          ActiveModel::Conversion +
                          extend ActiveModel::Naming +
                          extend ActiveModel::Translation

class Person
  include ActiveModel::Attributes

  attribute :name, :string      <- type specified
  attribute :active, :boolean, default: true     <- default value specified
end
=end

class BaseForm
  #include Virtus.model
  include ActiveModel::API
  include ActiveModel::Attributes
  
  VALID_BOOLEAN = [true, 1, false, 0, "true", "1", "false", "0"]

  attr_reader :has_error#:errors,

  def initialize(attributes = {})
    super attributes
    @errors = ActiveModel::Errors.new(self)
  end

  # ActiveRecord::Persistence
  def persisted?
    false
  end

  private
    def has_error?
      !!@has_error
    end

    def set_has_error
      @has_error = true
    end

    def set_errors(*models)
      models.compact.each do |mod|
        mod.errors.each do |k, v|
          if self.respond_to?(k)
            self.errors[k] << v
          else
            self.errors[:base] << v
          end
        end
      end
    end

    # Returns true if calls
    def commit_or_rollback(&b)
      res = true
      ActiveRecord::Base.transaction do
        res = b.call
        raise ActiveRecord::Rollback  unless res
      end

      res
    end
end

