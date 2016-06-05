class BooksController < ApplicationController
  before_action :set_author
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = @author.books
  end

  def new
    @book = @author.books.new
  end

  def edit
  end

  def create
    @book = @author.books.new(book_params)
    if @book.save
      redirect_to author_books_url, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to author_books_url, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_book
      @book = @author.books.find_by_id(params[:id])
      redirect_to author_books_url(@author), :alert => "Book can't be found." unless @book
    end

    def book_params
      params.require(:book).permit(:title, :description)
    end

    def set_author
      @author = Author.find(params[:author_id])
    end
end
