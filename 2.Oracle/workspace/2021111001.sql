2021-1110-01)
 5) BETWEEN 연산자
  . 범위를 지정할때 사용되는 연산자
  . AND 연산자로 대치될 수 있다
  (사용형식)
  expr BETWEEN 데이터1 AND 데이터2
  - 'expr' 값이 '데이터1' 에서 '데이터2' 사이에 존재하면 결과가 참
  - '데이터1' 과 '데이터2' 는 같은 타입이어야 함
  - 사용할 수 있는 데이터 타입은 모든 타입 가능
  - 특히, 날짜 구간 설정에 많이 사용
  
 사용예) 사원테이블에서 2006년 ~ 2007년에 입사한 사원을 조회하시오.
        Alias는 사원번호, 사원명, 부서코드, 입사일, 직무코드이며
        입사일 순, 부서코드 순으로 출력하시오.
        
        SELECT EMPLOYEE_ID AS 사원번호,
                EMP_NAME AS 사원명,
                DEPARTMENT_ID AS 부서코드,
                HIRE_DATE AS 입사일,
                JOB_ID AS 직무코드
        FROM HR.EMPLOYEES
        WHERE HIRE_DATE BETWEEN '20060101' AND '20071231'
      --WHERE HIRE_DATE BETWEEN TO_DATE('20060101') AND TO_DATE('20071231')
      --WHERE HIRE_DATE >= TO_DATE('20060101') AND HIRE_DATE <= TO_DATE('20071231')
        ORDER BY 4,3;
        
 사용예) 매입테이블(BUTPROD)에서 2005년 2월 매입LIST를 출력하시오.
        Alias 는 날짜, 상품코드, 수량, 금액이다.
        
        SELECT BUY_DATE AS 날짜,
                BUY_PROD AS 상품코드,
                BUY_QTY AS 수량,
                BUY_COST * BUY_QTY AS 금액
        FROM BUYPROD
        WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND TO_DATE('20050228')
        --WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAT (TO_DATE('20050205'))
        --WHERE BUY_DATE BETWEEN ('20050201') AND ('20050228')
        ORDER BY 1;
        
 (6) LIKE 연산자
  . 패턴을 비교하는 문자열 비교 연산자
  . 패턴문자 (와일드카드) 로는 '%', '_' 가 사용
    (a) '%'
     - '%' 가 사용된 위치에서 그 이후의 모든 문자열과 대응 됨
     ex) '홍%' : 첫 글자가 '홍' 이고 나머지 글자는 어떤 글자와도 대응되어 참의 결과 반환
         '%홍' : 끝 글자가 '홍' 인 모든 문자열과 대응 됨
         '%홍%' : 문자열 내부에 '홍' 문자가 있는 모든 문자열과 대응 됨
         
    (b) '_'
     - '_' 가 사용된 위치에 한 문자와 대응
     ex) '홍_' : 두 글자로 구성되고 첫 글자가 '홍'인 문자열만 대응
         '_홍' : 끝 글자가 '홍' 인 2자로 구성된 문자열과 대응됨 
         '_홍_' : 문자열 내부에 '홍' 문자가 있는 세글자로 구성된 문장열과 대응
         
    -- 원본 데이터의 양이 방대할 때, 자주 사용하면 실행속도가 많이 떨어진다.
    -- 숫자열과 비교할 수 없고, 되도록이면 날짜열 비교에는 사용하지 말자.
    
 사용예) 회원테이블에서 거주지가 '대전' 인 회원 정보를 조회하시오.
        Alias는 회원번호, 회원명, 주소, 직업
        
        SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                MEM_ADD1 || ' ' || MEM_ADD2 AS 주소,
                MEM_JOB AS 직업
        FROM MEMBER
        WHERE MEM_ADD1 LIKE '대전%'
        ORDER BY 1;
                
 사용예) 장바구니 테이블에서 2005년 7월 구매이력이 있는 회원번호를 조회하시오.
 
        SELECT DISTINCT CART_MEMBER AS 회원번호
        FROM CART
       -- WHERE CART_NO BETWEEN ('20050701') AND ('20050731');
        WHERE CART_NO LIKE '200507%'
        
        --SELECT DISTINCT : 중복값을 제거하고 검색을 출력.
 
 사용예) 상품명이 '대우' 가 포함된 모든 상품을 조회하시오.
        Alias는 상품번호, 상품명, 거래처코드, 분류코드 
        
        SELECT PROD_ID AS 상품번호,
                PROD_NAME AS 상품명,
                PROD_BUYER AS 거래처코드,
                PROD_LGU AS 분류코드
        FROM PROD
        WHERE PROD_NAME LIKE '%대우%'
        ORDER BY 1;
        
    
  
        
        
      