class PagesController < ApplicationController
  include PagesHelper

  def home
  end

  def search
    if params[:search].blank?
      redirect_to(root_path, alert: "Empty field!") and return
    else
      @parameter = params[:search].downcase
      @results = find_the_best_words(@parameter)
    end
  end


  # def find_word
  #   if params[:search].blank?
  #     redirect_to root_path
  #     p 'true'
  #   else
  #     @search = params[:search].downcase
  #     @results = Word.where(:firstLetter => @search[0], :secondLetter => @search[1]).pluck :word
  #     p 'false'
  #   end
  # end

end
