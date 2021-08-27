class PostsController < ApplicationController
  # before_action :authenticate_user! # 로그인이 된 상태에서 요청을 처리해야 합니다.
  @@user = User.find_by(id: 1) # 고정 값으로 사용할 유저
  def index
    @posts = Post.all
    render json: @posts
  end

  def create
    # 글 생성
    @post = Post.new
    @post.title = params[:title]
    @post.content = params[:content]
    @post.user = @@user # 유저 고정값

    if @post.valid? # 유효성 검사
      @post.save
      # 키워드 알림 비동기 처리
      KeywordPostUpdateJob.perform_later(@post)
      render json: @post, status: :ok # 정상 생성시 리턴
    else
      render json: @post.errors.messages, status: :bad_request # Bad Request
    end
  end
end
