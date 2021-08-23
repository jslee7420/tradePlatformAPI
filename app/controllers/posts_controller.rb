class PostsController < ApplicationController
    # before_action :authenticate_user! # 인증이 된 상태에서만 요청을 처리해야 합니다.
    def index
        @posts = Post.all
        render json: @posts
    end

    def create
        # 글 생성
        @post = Post.new
        @post.title = params[:title]
        @post.content = params[:content]
        @post.user = User.find(1) # 유저 고정값
        @post.save

        # 키워드 알림 비동기 처리(일단 동기적 처리 먼저 구현)
        # 모든 키워드마다 해당 키워드가 글에 존재하는지 여부 확인
        @results = []
        @keywords = Keyword.all
        @user_keyword
        @keywords.each do |x|
            if @post.title.include?(x.keyword) ||@post.content.include?(x.keyword)  # 존재하면 알림(내가 쓴 글이면 X)
                # UserKeyword 테이블에서 해당하는 내용 뽑기
                @user_keyword = UserKeyword.where(keyword: x)
                #결과 배열에 넣기
                @results.append(@user_keyword)
            end
        end
        # 뽑은 내역 출력
        i=1
        for result in @results
            puts i
            puts result
            i +=1
        end
    end
end