class BooksController < ApplicationController
  before_filter :book, only: [:show, :edit, :update, :destroy]

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.create(params[:book])
    respond_to do |format|
      format.js
      format.html { redirect_to action: :index }
    end
  end

  def update
    @book.update_attributes(params[:book])
    redirect_to action: :index
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.js { render nothing: true }
      format.html { redirect_to action: :index }
    end
  end

  def search
    @books = Book.where('title LIKE ?', "%#{params[:query]}%")
  end

  private

  def book
    @book = Book.find(params[:id])
  end
end