class UserSelectJob < ApplicationJob
  queue_as :keywords

  def perform(keyword)
    # UserKeyword 테이블에서 해당하는 내용 뽑기
    @user_keyword = UserKeyword.where(keyword_id: keyword.id)
    # 결과 배열에 넣기
    puts "===================================="
    puts "keyword: " + keyword.keyword
    @user_keyword.each do |x|
      print x.user.email + ", "
    end
    puts
    puts "===================================="
  end
end
