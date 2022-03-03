2021-1110-02)함수
 - 오라클사에서 제공하는 미리 컴파일되어 실행가능한 모듈
 - 문자열, 숫자, 날짜, 형변환, NULL처리, 집계함수 등이 제공됨
 1. 문자열 함수
  1) CONCAT (c1, c2)
   - 주어진 문자열 자료 'c1' 과 'c2' 를 결합하여 새로운 문자열을 반환
   - 문자열 결합연산자('||')와 동일기능 제공 
 사용예) 회원테이블에서 직업이 '자영업'인 회원의 회원번호, 회원명, 주민번호, 주소를 조회하되 주민번호는 'XXXXXX-XXXXXXX'
        형식으로, 주소는 기본주소와 상세주소를 ' ' 을 삽입하여 출력하시오.
        
        SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                CONCAT(MEM_REGNO1,CONCAT('-',MEM_REGNO2)) AS 주민번호,
                CONCAT(MEM_ADD1,CONCAT(' ',MEM_ADD2))AS 주소
        FROM MEMBER
        WHERE MEM_JOB LIKE '%자영업%';
        
        -- c:문자열 n:숫자 d:날짜열
        
  2) LOWER(c1), UPPER(c1), INITCAP(c1)
   - LOWER(c1) : c1 문자열에 포함된 모든 문자열을 소문자로 변환
   - UPPER(c1) : c1 문자열에 포함된 모든 문자열을 대문자로 변환
   - INITCAP(c1) : c1 문자열에 포함된 단어의 첫 글자만 대문자로 변환
   
 사용예) 회원번호 'D001' 회원이 2005년 5월 구매한 정보를 조회하시오.
        Alias는 날짜, 상품번호, 구매량
        
        SELECT SUBSTR(CART_NO,1,8) AS 날짜,
                CART_PROD AS 상품번호,
                CART_QTY AS 구매량
        FROM CART
        WHERE CART_NO LIKE ('200505%')
              AND UPPER(CART_MEMBER) = 'D001';
              
        SELECT INITCAP (LOWER(FIRST_NAME)||'.'||LOWER(LAST_NAME))
        FROM HR.EMPLOYEES;
        
 3) LPAD(c1,n[,c2]), RPAD(c1,n[c2])
  - n만큼 확보된 기억공간에 c1을 왼쪽(LPAD), 오른쪽(RPAD)부터 삽입하고 남는 기억공간은 c2로 채워 반환
  - c2가 생략되면 공백이 채워진다.
  
 사용예) 
    SELECT LPAD(TO_CHAR(PROD_COST),10,'*'),
           RPAD(TO_CHAR(PROD_COST),10,'*'), 
           LPAD(PROD_NAME,30),
           RPAD(PROD_NAME,30)
    FROM PROD;
        
 4) LTRIM(c1[,c2]),RTRIM(c1[,c2])  -- 거의 공백을 제거하기 위해 사용한다.
  - 주어진 문자열 c1에서 왼쪽부터 (LTRIM), 오른쪽부터(RTRIM) c2 문자열과 일치하는 부분을 삭제
  - c1 에서 c2를 찾을때 반드시 c1의 첫번째 문자열부터 c2와 동일해야함
  - c2 가 생략되면 공백을 찾아 삭제 
  - c1 내부의 공백은 제거하지 못 한다.
  
 사용예)
    SELECT LTRIM('PERSIMON APPLE BANANA','ABCDEFGHIJKLMNOPQRSTUVWSYZ'),
           RTRIM('PERSIMON APPLE BANANA','NA'), 
           LTRIM('          PERSIMON APPLE BANANA            ',' PE'),
           RTRIM('          PERSIMON APPLE BANANA            ')
    FROM DUAL;
    
 5) TRIM (c1)
  - 문자열 c1에 왼쪽과 오른쪽에 존재하는 공백을 제거
  - 문자열 내부의 공백제거는 불가능
  
 사용예)
    SELECT TRIM('      PERSION APPLE BANANA          ')
    FROM DUAL;
    
 사용예) 사원테이블의 EMP_NAME 컬럼의 데이터 타입을 고정길이 문자열로 변경하시오
 
    ALTER TABLE HR.EMPLOYEES
        MODIFY(EMP_NAME CHAR(80));
        
      ALTER TABLE HR.EMPLOYEES
        MODIFY(EMP_NAME VARCHAR2(80));
        
        UPDATE HR.EMPLOYEES
            SET EMP_NAME = TRIM(EMP_NAME);
        COMMIT;
        
        SELECT EMP_NAME 
        FROM HR.EMPLOYEES;
        
 6) SUBSTR(c, sindex[, cnt])
  - 주어진 문자열 c에서 sindex 위치 부터 cnt갯수 만큼의 문자열을 추출하여 반환함
  - 시작위치는 1부터 시작됨
  - cnt 가 생략되면 sindex 부터 나머지 모든 문자열 반환
  - sindex 의 값이 음수면 문자열 c의 오른쪽부터 처리한다.
  
 사용예) 
    SELECT SUBSTR('ILPOSTINO BOYHOOD' , 2, 5),
           SUBSTR('ILPOSTINO BOYHOOD' , 2),
           SUBSTR('ILPOSTINO BOYHOOD' , -12, 5)
    FROM DUAL;
    
 사용예) 장바구니 테이블에서 2005년 4월과 6월에 판매된 상품별 판매집계를 조회하시오.
        Alias는 상품코드, 판매수량, 판매금액
        
        SELECT A.CART_PROD AS 상품코드,
                SUM(A.CART_QTY) AS 판매수량,
                SUM(A.CART_QTY*B.PROD_PRICE) AS 판매금액
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
        -- AND A.CART_NO LIKE '200504%' OR A.CART_NO LIKE '200506%'
        -- AND ( SUBSTR(A.CART_NO,1,6) = '200504' OR SUBSTR(A.CART_NO,1,6) = '200506')
        -- SUBSTR(A.CART_NO,1,6) IN ('200504','200506')
        GROUP BY A.CART_PROD;
        
        
        A.CART_NO LIKE '200504%'; --AND A.CART_NO LIKE ('200506%');
        
        --두개 이상의 테이블이 사용된다면, 반드시 WHERE 절에서 조인 조건을 선언해야한다.
        
 7)REPLACE(c1, c2[,c3]) -- 단어 안에 있는 공백을 제거하는 함수
  - 주어진 문자열 c1에서 c2문자열을 찾아 c3문자열로 치환
  - c3를 생략하면 c2를 찾아 삭제 함
        
 사용예) 
        SELECT REPLACE('PERSIOM APPLE BANANA', 'A', 'M'),
               REPLACE('PERSIOM APPLE BANANA', 'A'),
               REPLACE('PERSIOM APPLE BANANA', ' ')
        FROM DUAL;
        
        ===============================================
        SELECT DEPARTMENT_ID AS 부서코드,
                ROUND(AVG(SALARY)) AS 평균급여
        FROM HR.EMPLOYEES 
        GROUP BY DEPARTMENT_ID
        ORDER BY 1;
        