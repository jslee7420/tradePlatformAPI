class KeywordPostUpdateJob < ApplicationJob
  queue_as :keyword_post_create # job을 담을 큐

  # 주어진 문자열로 만들 수 있는 모든 substring 배열(키워드 후보들) 리턴
  # 키워드 길이를 1~30으로 제한했으므로 길이 1~30범위의 substring들만 생성
  def makeSubstring(str)
    len = str.length
    @substrings = []
    (0...len).each do |i|
      (i...i + 20).each do |j|
        if j >= len
          next
        end
        @substrings.append(str[i..j])
      end
    end
    @substrings
  end

  def perform(post)
    # title과 content에 포함된 문자열로 만들 수 있는 모든 부분 문자열 생성
    @substrings = [] # 부분문자열 배열
    @substrings += makeSubstring(post.title)
    @substrings += makeSubstring(post.content)

    # 각 부분 문자열에 대해서 keyword record 검색 시도
    @substrings.each do |substring|
      @keyword = Keyword.find_by(keyword: substring)
      if !@keyword.nil? # 키워드가 존재하는 경우
        # async 메소드 호출을 통한 병렬 처리
        UserSelectJob.perform_later(@keyword)
      end
    end
  end
end
