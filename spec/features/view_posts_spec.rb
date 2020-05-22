feature 'Viewing posts' do
  scenario 'A user can view all post' do
    visit('/')
    fill_in('Username', with: 'Test')
    click_button('Submit')
    click_link('All Posts')
    expect(page).to have_content('All Chitter Posts')
  end

  scenario 'Expect posts to have the date' do
    visit('/')
    fill_in('username', with: 'Test')
    click_button('Submit')
    fill_in('title', with: 'testy')
    fill_in('body', with: 'test2')
    click_button('Submit')

    expect(page).to have_content('testy')
    expect(page).to have_content('test2')
    expect(page).to have_content('Posted at')
  end
end
