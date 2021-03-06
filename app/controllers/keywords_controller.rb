class KeywordsController < ApplicationController
  def index
    @keywords = Keyword.all
    render json: @keywords
  end

  def create
    # 유효성 검사
    @keyword = Keyword.new
    @keyword.keyword = params[:keyword]
    if !@keyword.valid? # 유효하지 않을시 에러 메세지 전송
      return render json: @keyword.errors.messages, status: :bad_request
    end
    if (@keyword = Keyword.find_by(keyword: params[:keyword])).nil? # 새로운 키워드인 경우
      # Keyword 데이터 추가
      @keyword = Keyword.new
      @keyword.keyword = params[:keyword]
      @keyword.count = 0

      # User_Keyword 데이터 추가
      @user_keyword = UserKeyword.new
      @user_keyword.user = User.find(1) # 유저 고정값
      @user_keyword.keyword = @keyword

      # DB에 반영
      @keyword.save
      @user_keyword.save
      # 생성확인 메세지 전송
      render json: @keyword, status: :ok

    else # Keyword table에 존재하는 키워드인 경우
      # 이미 사용자가 등록한 키워드인 경우 생성하지 않음
      if UserKeyword.find_by(user: User.find(1)) != nil # 유저 고정값
        render json: {message: "이미 등록한 키워드입니다."}, status: :bad_request
        return
      end
      # Keyword 데이터 변경
      @keyword.count += 1 # 기존 키워드의 count 필드 1증가

      # User_Keyword 데이터 추가
      @user_keyword = UserKeyword.new
      @user_keyword.user_id = User.find(1).id # 유저 고정값
      @user_keyword.keyword = @keyword

      # db에 반영
      @keyword.save
      @user_keyword.save

      # 생성확인 메세지 전송
      render json: @keyword, status: :ok
    end
  end

  def destroy
    # 존재하는 경우
    @keyword = Keyword.find(params[:id])
    @keyword.count -= 1 # 개수 감소

    # User_Keyword 테이블 값 변경
    @user_keyword = UserKeyword.find_by(user: User.find(1), keyword: @keyword) # 유저 고정값
    @user_keyword.destroy

    if @keyword.count == 0 # 마지막 이면 없애기
      @keyword.destroy
    end

    # 삭제 확인 메세지 전송
    render json: @keyword, status: :ok
  rescue Exception # 존재 하지 않는 경우 예외 처리
    # 존재하지 않음 메세지 전송
    render json: {message: "존재하지 않는 키워드입니다."}, status: :not_found
  end
end
