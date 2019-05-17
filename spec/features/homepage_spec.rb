require 'rails_helper'

describe 'Some home page sanity checks' do
    it 'pins records to the home page map and allows users to navigate to them' do
      Capybara.current_driver = :selenium
      visit '/'
      expect(page).to have_content('Browse all 8 items from 189 historical societies, libraries, archives, and cultural organizations across Minnesota')
      find(:xpath, '//*[@id="search"]').click
      expect(page).to have_content('A. Aberle residence, 214 South Peck Street, Fergus Falls, Minnesota')
    end
end

