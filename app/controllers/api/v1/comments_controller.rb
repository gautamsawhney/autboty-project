class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    @comments = policy_scope(Comment).page(params[:page]).per(params[:per])

    render json: @comments
  end

  # GET /comments/1
  def show
    authorize @comment
    render json: @comment
  end

  # POST /comments
  def create
    @comment = Comment.new(permitted_attributes(Comment.new))
    authorize @comment #Authorizing

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    authorize @comment
    if @comment.update(permitted_attributes(@comment))
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    authorize @comment
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
end
