class ReviewsController < ApplicationController
  before_filter :authorize
  def create
    @product = Product.find params[:product_id]
    @review = @product.reviews.new review_params
    @review.user_id = current_user.id 

    # byebug

    if @review.save
      redirect_to product_path(params[:product_id]), notice: "Review created"
    else 
      redirect_to product_path(params[:product_id]), notice: "There was an error adding the review: #{@review.errors.full_messages}"
    end
  end

  def destroy 
    Review.find(params[:id]).destroy
    redirect_to product_path(params[:product_id]), notice: "Review deleted!"
  end


  

  private

  def review_params
    params.require(:review).permit(:description, :rating)
  end

end
