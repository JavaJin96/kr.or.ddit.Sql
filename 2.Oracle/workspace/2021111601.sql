2021-1116-01)

 4. 변환함수
  - 오라클에서 사용하는 데이터의 형변환을 담당
  - CAST, TO_CHAT, TO_DATE, TO_NUMBER 함수 제공 
  -- TO_CHAR 고정길이 문자열을 가변길이 문자열로 변경한다(문자열 - 문자열, 날자열 - 문자열, 숫자열 - 문자열)
  -- TO_DATE, TO_NUMBER 는 문자열 - 날짜/숫자로 변환
  
  1) CAST(expt AS 타입명)
   . 'expt'로 제시된 데이터나 컬럼 값이 '타입명'으로 형이 변환된다.
   
 사용예) SELECT 1234,CAST(1234 AS VARCHAR2(10)) AS "COL1",
                CAST(1234 AS CHAR(10)) AS "COL2"
        FROM DUAL; 
        
 사용예) 2005년 7월 일자별 판매집계를 조회하시오.
        Alias는 일자, 판매수량합계, 판매금액합계
        
        SELECT CAST(SUBSTR(A.CART_NO,1,8) AS DATE) AS 일자,
               SUM (A.CART_QTY) AS 판매수량합계,
               SUM (A.CART_QTY * B.PROD_PRICE) AS 판매금액합계
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
        AND A.CART_NO LIKE '200507%'
        GROUP BY SUBSTR(A.CART_NO,1,8)
        ORDER BY 1;
        
 2) TO_CHAR (expr[,'fmt'])
  . 숫자, 날짜, 문자열 타입을 문자열 타입으로 변환
  . 'expr' 이 문자열인 경우 CHAR, CLOB 타입을 VARCHAR2 로 변환만 가능
  . 'fmt' : 변환하려는 형식지정문자열로 날짜와 숫자형으로 분리
  . 날짜형 FORMAT STRING
 ---------------------------------------------------------------------------
  형식지정문자열       의미          사용예
 ---------------------------------------------------------------------------
  AD, BC            서기          SELECT TO_CHAR(SYSDATE, 'BC') FROM DUAL; 
  CC                세기          SELECT TO_CHAR(SYSDATE, 'BC CC') FROM DUAL;
  YYYY,YYY,YY,Y     년도          SELECT TO_CHAR(SYSDATE, 'CC YYYY') FROM DUAL;
  MONTH,MON,MM,RM   월            SELECT TO_CHAR(SYSDATE, 'YYYYMMDD MONTH MON') FROM DUAL;
  DD,DDD,J          일            SELECT TO_CHAR(SYSDATE, 'YYMMDD DDD D') FROM DUAL;  -- DDD : 1월 1일 부터 지금까지 경과된 시간 (320일)   / J : -4712을 기준으로 지금까지 경과된 일수
  DAY,DY,D          요일          SELECT TO_CHAR(SYSDATE, 'YYMMDD DAY DY J') FROM DUAL;
  Q                 분기          SELECT TO_CHAR(SYSDATE, 'YYMMDD Q') FROM DUAL;
  AM,PM,A.M.,P.M.   오전/오후      SELECT TO_CHAR(SYSDATE, 'YYMMDD AM PM A.M. P.M.') FROM DUAL; -- 전부 똑같은 값 출력
  HH,HH24,HH12      시            SELECT TO_CHAR(SYSDATE, 'YYMMDD HH HH12 HH24') FROM DUAL;
  MI                분            SELECT TO_CHAR(SYSDATE, 'YYMMDD HH24 MI') FROM DUAL;
  SS,SSSSS          초            SELECT TO_CHAR(SYSDATE, 'YYMMDD HH24 MI SSSSS') FROM DUAL;
  "사용자지정"                     SELECT TO_CHAR(SYSDATE, 'YY"년"MM"월"DD"일" HH24:MI:SS Q"분기"') FROM DUAL;
  --------------------------------------------------------------------------
  
  
   .  숫자형 FORMAT STRING
  --------------------------------------------------------------------------
  형식지정문자열       의미                     사용예
  --------------------------------------------------------------------------
        9           무효의 0을 공백처리         SELECT TO_CHAR(1234, '99,999') FROM DUAL; 
        0           무효의 0을 '0'출력         SELECT TO_CHAR(1234, '00,000') FROM DUAL; 
        $, L        숫자 왼쪽에 화폐기호        SELECT TO_CHAR(1234, 'L99,999') FROM DUAL; 
        -- 숫자단위의 ',', '$', 'L' 이 붙어 출력되면 숫자로서의 가치 상실(문자열화)된다.(연산 불가능)
        MI          음수인 경우 우측에 '-'      SELECT TO_CHAR(-1234, '99,999MI' )FROM DUAL; 
                    부호로 출력                  SELECT TO_CHAR(1234, '99,999MI')FROM DUAL; 
        PR          음수를 '< >' 안에 표현      SELECT TO_CHAR(-1234, '99,999PR')FROM DUAL; 
      ,(COMMA)      3자리마다의 자리점         
      .(DOT)        소숫점                    
  --------------------------------------------------------------------------        
  
 3) TO_NUMBER(expr[,'fmt'])
  . 'expr' (문자열 자료)를 숫자형 자료로 변환
  . 'expr' 은 반드시 숫자로 변환 가능해야함
  . 'fmt' 는 TO_CHAR 의 숫자 형식지정문자열과 동일하나 숫자로 취급될 수 있는 문자열만 가능('9', '.', 등)
 
 사용예) SELECT TO_NUMBER(MEM_BIR)
        FROM MEMBER;
        
        SELECT TO_NUMBER('12,345', '99999'), 
               TO_NUMBER('<12,345>', '99999PR'),
               TO_NUMBER('￦12,345', 'L99999')
        FROM DUAL;
        
 4)TO_DATE(expr[,'fmt'])
  . 사용되는 'fmt' 는 TO_CHAR 변환함수에 사용하는 형식지정문자열이 사용되나, 날자로 변환될 수 있는 문자열 이어야함
  . 문자열자료('expr') 을 날짜로 변환
  
 사용예) SELECT TO_DATE('20210228'),
               TO_DATE('20210220161759', 'YYYYMMDDHH24MISS')
        FROM DUAL;
  
  
  