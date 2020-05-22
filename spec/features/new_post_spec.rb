feature 'Adding a new post' do
  scenario 'Page has 2 fields' do
    visit('/')
    fill_in('username', with: 'Test')
    click_button('Submit')
    expect(page).to have_content('Title')
    expect(page).to have_content('Body')
  end

  scenario 'Page has link directly to see all posts' do
    visit('/')
    fill_in('username', with: 'Test')
    click_button('Submit')
    click_link 'All Posts'
    expect(page).to have_content('All Chitter Posts')
  end

  scenario 'A user can add a post' do
    visit('/')
    fill_in('username', with: 'Test')
    click_button('Submit')
    fill_in('title', with: 'newtest110')
    fill_in('body', with: 'generic text')
    click_button('Submit')

    expect(page).to have_content('newtest110')
    expect(page).to have_content('generic text')
  end
end
