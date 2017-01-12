require 'test_helper'

class UrlTagListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @url_tag_list = url_tag_lists(:one)
  end

  test "should get index" do
    get url_tag_lists_url
    assert_response :success
  end

  test "should get new" do
    get new_url_tag_list_url
    assert_response :success
  end

  test "should create url_tag_list" do
    assert_difference('UrlTagList.count') do
      post url_tag_lists_url, params: { url_tag_list: { tags: @url_tag_list.tags, url: @url_tag_list.url } }
    end

    assert_redirected_to url_tag_list_url(UrlTagList.last)
  end

  test "should show url_tag_list" do
    get url_tag_list_url(@url_tag_list)
    assert_response :success
  end

  test "should get edit" do
    get edit_url_tag_list_url(@url_tag_list)
    assert_response :success
  end

  test "should update url_tag_list" do
    patch url_tag_list_url(@url_tag_list), params: { url_tag_list: { tags: @url_tag_list.tags, url: @url_tag_list.url } }
    assert_redirected_to url_tag_list_url(@url_tag_list)
  end

  test "should destroy url_tag_list" do
    assert_difference('UrlTagList.count', -1) do
      delete url_tag_list_url(@url_tag_list)
    end

    assert_redirected_to url_tag_lists_url
  end
end
