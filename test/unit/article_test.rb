require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "presence" do
	  article=Article.new
	  article.title="A"*201
	  assert article.invalid?
	  assert article.errors.include?(:title)
	  article.title="A"*200
	  assert article.invalid?
	  assert !article.errors.include?(:title)
  end
  
  test "expired_at" do
  	article=Factory.build(:article)
  	article.released_at=Time.current
  	article.expired_at=1.days.ago
  	assert article.invalid?
  	assert article.errors.include?(:expired_at)
  end
  
  test "no_expiration" do
  	article=Factory.build(:article)
  	article.no_expiration=true
  	assert article.valid?
  	assert_nil article.expired_at
  end

  test "readable_for" do
    article1=Factory(:article, title: "ima", released_at: 1.days.ago, expired_at: 1.days.from_now)
    article2=Factory(:article, title: "kako", released_at: 2.days.ago, expired_at: 1.days.ago)
    article3=Factory(:article, title: "future2", released_at: 1.days.from_now, expired_at: 2.days.from_now)
    article4=Factory(:article, title: "no owata", released_at: 1.days.ago, expired_at: nil)
    article5=Factory(:article, title: "member only", released_at: 1.days.ago, expired_at: nil, member_only: true)

    articles=Article.readable_for(nil)
    assert_includes articles, article1, "includes ima"
    assert_not_includes articles, article2, "not include kako"
    assert_not_includes articles, article3, "not include mirai"
    assert_includes articles, article4, "expired==nil"
    assert_not_includes articles, article5, "mem only"
  end
end
