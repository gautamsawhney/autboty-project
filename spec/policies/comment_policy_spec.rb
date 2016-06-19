require 'rails_helper'

describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  let(:comment) { Comment.create }

  #add_here
  context "being a/an associate_software_engineer" do
    let(:user) {  User.create('roles' => 'associate_software_engineer', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: AssociateSoftwareEngineer
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: AssociateSoftwareEngineer
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end
  context "being a/an software_engineer" do
    let(:user) {  User.create('roles' => 'software_engineer', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: SoftwareEngineer
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: SoftwareEngineer
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end
  context "being a/an technical_lead" do
    let(:user) {  User.create('roles' => 'technical_lead', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: TechnicalLead
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: TechnicalLead
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end
  context "being a/an business_owner" do
    let(:user) {  User.create('roles' => 'business_owner', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: BusinessOwner
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: BusinessOwner
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end
  context "being a/an business_admin" do
    let(:user) {  User.create('roles' => 'business_admin', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: BusinessAdmin
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: BusinessAdmin
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end

end
