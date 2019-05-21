require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do
  let(:email) {'test@gmail.com'}
  let(:password) {'123'}
  let(:password_confirmation) {'123'}

  before(:each) do      
    u = User.create!(        
      name: 'test name',
      email: email, 
      password: password,
      password_confirmation: password_confirmation
    ) 
  end

  after(:each) do
    User.delete_all
  end

  
  scenario "Login" do
    # ACT
    visit login_path
    # byebug
    # DEBUG
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_on('Submit')
    
    # VERIFY
    logintext = 'Signed in as: ' + User.first.name
    save_screenshot
    expect(page).to have_text logintext
    expect(page).to have_text 'Logout'
    page.save_screenshot
  end
end
