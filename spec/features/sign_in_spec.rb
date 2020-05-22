feature 'Signing in' do
  scenario 'has a username field' do
    visit('/')
    expect(page).to have_content 'Username'
  end

  scenario 'has a title' do
    visit('/')
    expect(page).to have_content 'Chitter!'
  end
end
