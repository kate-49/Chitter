feature 'Signing in' do
  scenario 'has a username field' do
    visit('/')
    expect(page).to have_content 'Username'
  end

  scenario 'has a title' do
    visit('/')
    expect(page).to have_content 'Chitter!'
  end

  scenario 'it displays your name on the posts page' do
    visit('/')
    fill_in :username, with: 'Kate'
    click_button 'Submit'
    expect(page).to have_content 'Kate'
  end
end
