require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "Validations" do
    subject { described_class.create( name: 'test name', email: 'test@email.com', password: '123', password_confirmation: '123')}
    it "is not valid if name is blank" do
      subject.name = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Name can't be blank")
    end
    it "is not valid if email is blank" do
      subject.email = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Email can't be blank")
    end
    it "is not valid if password is blank" do
      subject.password = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Password can't be blank")
    end
    it "is not valid if password confirmation is blank" do
      subject.password_confirmation = nil
      subject.valid?
      expect(subject.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "is not valid if password is not equal password confirmation" do
      subject.password = '234'
      subject.valid?
      expect(subject.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "is not valid if password length is < 3" do
      subject.password = '1'
      subject.password_confirmation = '1'
      subject.valid?
      expect(subject.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
    describe "if user uses an existing email" do
      it "is not valid if email exists" do
        user = described_class.create( name: 'test name', email: 'TEST@EMAIL.COM', password: '123', password_confirmation: '123')
        subject
        expect(subject.errors.full_messages).to include("Email has already been taken")
      end
    end
  end

  describe ".authenticate_with_credentials" do
    let(:email) {'test@gmail.com'}
    let(:password) {'123'}
    let(:password_confirmation) {'123'}

    before(:each) do      
      u = User.create(        
        name: 'test name',
        email: email, 
        password: password,
        password_confirmation: password_confirmation
      ) 
    end

    after(:each) do
      User.delete_all
    end

    it "should return nil if authentication fails" do
      userback = User.first.authenticate_with_credentials(email, '1231321')
      expect(userback).to be_nil
    end

    it "should return the user if authentication passes" do
      userback = User.first.authenticate_with_credentials(email, password)
      expect(userback).to eql(User.first)
    end

    it "should return the user if user adds spaces" do
      userback = User.first.authenticate_with_credentials(' test@gmail.com ', password)
      expect(userback).to eql(User.first)
    end

    it "should return the user if user adds funny case spelling" do
      userback = User.first.authenticate_with_credentials('TeST@gMaIl.CoM', password)
      expect(userback).to eql(User.first)
    end

  end


end
