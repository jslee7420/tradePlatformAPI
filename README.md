# 실행 환경

- ruby 3.0.2
- rails Rails 6.1.4.1
- sidekiq
- redis

키워드 알림의 비동기 실행을 위하여 sidekiq 라이브러리를 사용했습니다. sidekiq 사용을 위하여 redis가 필요합니다.

# 실행 방법

도커 컴포즈를 이용하여 자동으로 환경을 구축하여 실행하도록 했습니다.

```
docker-compose up
```

# 테스트 결과

1. 게시글 등록
   ![Post posts request](./img/PostPosts.png)
   ![Post posts request](./img/PostPosts2.png)

2. 키워드 등록
   ![Post keywords request](./img/PostKeywords.png)
   ![Post keywords request](./img/PostKeyword2.png)

3. 키워드 삭제
   ![Delete keywords request](./img/DeleteKeywords.png)
   ![Delete keywords request](./img/DeleteKeywords2.png)

4. 자동 알림 발송 기능
   ![Post posts request](./img/PostPosts.png)
   ![result](./img/select.png)

# 보완이 필요한 부분들

- 데이터 베이스를 sqlite3를 사용 → mysql을 사용하려고 했으나 설치가 안됨 오류 해결 못함
- 고정값의 authentication을 구현하지 못함(로그인 상태일때만 모든 기능이 작동하도록하여야 하지만 현재는 로그인 없이 게시물이나 키워드를 저장할때 user_id필드에 데이터 베이스에 존재하는 첫번째 user의 정보가 저장되도록 하였습니다.)
- keyword 모델의 count 변수 사용: 처음에는 특정 키워드에 대한 알림을 필요로 하는 사람의 수를 keyword모델의 count 변수에 숫자로 표현했습니다. 하지만 이렇게 하는 것 보다 model의 has_many 관계의 dependent 옵션을 사용하여 관리하는 것이 더 좋은 방법으로 생각됩니다.
- 응답 메세지를 어떠한 형식으로 보내주어야 하는지 잘 모르겠습니다. 현재는 성공한 경우 저장된 데이터를 응답하고 에러 발생시 에러 메세지를 응답으로 보내주도록 하였습니다.
- 테스트를 체계적으로 진행하지 못했습니다. 테스트를 자동화 할 수 있는 툴을 사용해야 할것으로 판단됩니다.
- db파일이 container안에서 생성되어 이를 확인하기 어렵습니다. Docker volume을 사용하면 호스트에 저장할 수 있다고 합니다. 이 부분에 보완이 필요합니다.
- 알림을 보내야할 사용자를 뽑아내는 것을 구현했지만 이를 어떻게 보여드려야 하는지 잘 모르겠습니다. 현재는 단순히 console창에 출력하도록 했습니다. 그러나 도커에서 작동할때는 출력이 안됩니다.
- 현재는 키워드에 대한 구분이 없이 알림 대상자를 선정합니다. 실제 알림을 보내려면 어떤 키워드에 대한 알림인지도 구분하여야 합니다.
