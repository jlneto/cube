require 'rails_helper'

RSpec.describe "solve the cube", type: :feature, js: true do

	it "should solve a cube" do
		visit root_path
		fill_in 'initial_state', with: 'BBORYYRGBWBGWGBGYWWOORRBYWOGGYGWOBOGOWBRBYRYRWOYROGRWY'
		click_button 'btn_solve'
		expect(page).to have_field('solution', with: "R' D F2 L' F B R' B' D' B U F2 U' R2 F2 R2 U' F2 R2 F2 D2 R2 U")
		click_button 'btn_show'
		expect(page).to have_content('Your solution has 23 steps')
	end

end