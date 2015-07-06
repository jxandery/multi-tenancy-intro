require_relative '../test_helper'

class BrowsesMerchantsTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = Storedom::Application
  end

  def test_it_views_a_merchants_store_page
    merchant = Merchant.create(name: "CoolersRUs")
    visit merchant_path(merchant)
    assert_equal 200, page.status_code

    within('h1') do
      assert page.has_content?(merchant.name), "page should have an CoolersRUs"
    end
  end

  def test_it_views_a_specific_item
    merchant = Merchant.create(name: "CoolersRUs")
    item = Item.create(name: 'new item', description: "cool item", merchant_id: merchant.id)
    visit merchant_path(merchant)

    within('li.item') do
      assert page.has_content?(item.name)
      assert page.has_content?(item.description)
      refute page.has_content?(item.merchant_id)
    end
  end

  def test_only_shows_items_for_given_merchant
    merchant_a = Merchant.create(name: "Merchant A")
    item_a = Item.create(name: 'new item a', description: "cool item a", merchant_id: merchant_a.id)

    merchant_b = Merchant.create(name: "Merchant B")
    item_b = Item.create(name: 'new item b', description: "cool item b", merchant_id: merchant_b.id)

    visit merchant_path(merchant_a)
    within('li.item') do
      assert page.has_content?(item_a.name)
      refute page.has_content?(item_b.name)
    end

    visit merchant_path(merchant_b)
    within('li.item') do
      assert page.has_content?(item_b.name)
      refute page.has_content?(item_a.name)
    end
  end

  def test_it_views_a_single_item
    merchant = Merchant.create(name: "Merchant")
    item_a = Item.create(name: 'new item a', description: "cool item b", merchant_id: merchant.id)

    visit merchant_item_path(merchant, item_a)
    assert_equal 200, page.status_code

    assert page.has_content?(item_a.name)
  end

  def test_it_redirects_incorrect_url_to_correct_merchant_url
    merchant_a = Merchant.create(name: "Merchant A")
    item_a = Item.create(name: 'new item a', description: "cool item a", merchant_id: merchant_a.id)

    merchant_b = Merchant.create(name: "Merchant B")
    item_b = Item.create(name: 'new item b', description: "cool item b", merchant_id: merchant_b.id)

    visit merchant_item_path(merchant_a, item_b)

    assert_equal merchant_item_path(merchant_b, item_b), current_path
  end
end

