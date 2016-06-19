class LocationPolicy < ApplicationPolicy

  # Autobot: Read Scope

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, "" unless user 
      @user  = user
      @scope = scope
    end

    def resolve
      if user.business_admin? || user.business_owner? || user.technical_lead? || user.software_engineer? || user.associate_software_engineer?
        scope.all
      else
        scope.none
      end
    end
  end

  # Autobot: Permitted Attributes



  # Autobot: Permitted Actions
def destroy?
                #return true if record.user_id == user.id
                user.business_admin? || user.business_owner? || user.technical_lead? || user.software_engineer? || user.associate_software_engineer?
              end
def update?
                #return true if record.user_id == user.id
                user.business_admin? || user.business_owner? || user.technical_lead? || user.software_engineer? || user.associate_software_engineer?
              end
 def show?
                  user.business_admin? || user.business_owner? || user.technical_lead? || user.software_engineer? || user.associate_software_engineer?
                end
def create?
                #return true if record.user_id == user.id
                user.business_admin? || user.business_owner? || user.technical_lead? || user.software_engineer? || user.associate_software_engineer?
              end


end
