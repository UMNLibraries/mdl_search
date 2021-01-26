require 'rails_helper'
require 'digest/sha1'

describe 'Browsing Homepage Map' do
    it 'pins records to the home page map and allows users to navigate to them' do
      Capybara.current_driver = :selenium
      visit '/'
      expect(find('#home_map')).to have_content('OpenStreetMap')
    end
end

