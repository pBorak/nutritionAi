class SignUpForm
  include ActiveModel::Model

  attr_accessor :email, :first_name, :last_name, :password,
                :password_confirmation, :sex, :calorie_spread_ratio,
                :fat_ratio, :protein_ratio, :activity_level

  validate :validate_children

  def save
    if valid?
      persist!
      true
    else
      false
    end
  end

  def user
    @user ||= begin
      User.new(
        email: email,
        first_name: first_name,
        last_name: last_name,
        password: password,
        password_confirmation: password_confirmation,
      )
    end
  end

  def profile
    @profile ||= begin
       user.build_profile(
         sex: sex,
         calorie_spread_ratio: calorie_spread_ratio,
         fat_ratio: fat_ratio,
         protein_ratio: protein_ratio,
         activity_level: activity_level,
       )
     end
  end

  private

  def persist!
    ActiveRecord::Base.transaction do
      user.save!
      profile.save!
    end
  end

  def validate_children
    if user.invalid?
      promote_errors(user.errors)
    end

    if profile.invalid?
      promote_errors(profile.errors)
    end
  end

  def promote_errors(child_errors)
    child_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end
end
