class StaticController < ApplicationController

  def index
    if user_signed_in? && current_user.subscribed == true
      redirect_to prospects_path
    end
  end
  def services
  end
  def about
  end
  def contact
  end
  def portfolio_1
  end
  def portfolio_item
  end
  def blog_home_2
  end
  def blog_post
  end
  def full_width
  end
  def sidebar
  end
  def faq
  end
  def pricing
  end
  def error
  end

end
