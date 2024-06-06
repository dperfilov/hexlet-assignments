# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'test_can open all Bulletins' do
    get bulletins_path

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'test_can open one Bulletin' do
    # debugger

    # item = Bulletin.create(title: 'Test', body: 'Test body')

    get bulletin_path(bulletins(:item1))

    assert_response :success
    assert_select 'h1', 'Test fixture'
    assert_select 'p', 'Body test fixture'
  end
end
