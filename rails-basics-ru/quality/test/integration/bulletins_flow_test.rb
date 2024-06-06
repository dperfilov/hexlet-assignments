# frozen_string_literal: true

require 'test_helper'

class BulletinsFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test 'can open all items' do
    get bulletins_path

    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'can open one item' do
    # debugger

    # item = Bulletin.create(title: 'Test', body: 'Test body')

    get bulletin_path(bulletins(:item1))

    assert_response :success
    assert_select 'h1', 'Test fixture'
    assert_select 'p', 'Body test fixture'
  end
end
