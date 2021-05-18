class Public::SearchController < ApplicationController

  def search
    @model = params["model"]
    @method = params["method"]
    @content = params["content"]
    @records = search_for(@model, @method, @content)
  end

  private

  def search_for(model, content, method)
    if model == "end_user"
      if method == 'match'
        EmdUser.where(name: content)
      elsif method == 'forword'
        EndUser.where('name LIKE ?', "#{content}%")
      elsif method == 'backward'
        EndUser.where('name LIKE ?', "%#{content}")
      else
        EndUser.where('name LIKE ?', "%#{content}%")
      end

    elsif model == "blog"
      if method == 'match'
        Blog.where(title: content)
      elsif method == "forword"
        Blog.where('title LIKE ?', "#{content}%")
      elsif method == "backward"
        Blog.where('title LIKE ?', "%#{content}")
      else
        Blog.where('title LIKE ?', "%#{content}%")
      end
    end
  end
end
