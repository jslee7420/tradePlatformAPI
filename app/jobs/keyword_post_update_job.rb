class KeywordPostUpdateJob < ApplicationJob
  queue_as :keyword_post_create # job을 담을 큐

  def perform(post)
    # 모든 키워드마다 해당 키워드가 글에 존재하는지 여부 확인
    @results = [] # 키워드를 포함하는 UserKeyword 데이터를 담는 배열
    @keywords = Keyword.all 
    @user_keyword
    @keywords.each do |x|
        if post.title.include?(x.keyword) ||post.content.include?(x.keyword)  # 존재하면 알림(내가 쓴 글이면 X)
            # UserKeyword 테이블에서 해당하는 내용 뽑기
            @user_keyword = UserKeyword.where(keyword_id: x.id)
            #결과 배열에 넣기
            @results.concat(@user_keyword)
        end
    end
    # 뽑은 내역 출력
    puts "=======================키워드 알림 대상자=========================="
    @results.each do |x|
      puts x.user.email
    end
  end
end
