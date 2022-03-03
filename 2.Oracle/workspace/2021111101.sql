2021-1111-01)
 2. 숫자 함수
  1) 수학적 함수
   - 수학에서 많이 사용되는 지수, 삼각함수 등을 제공
   - ABS(n) : n에 대한 절대값 반환
   - SIGN(n) : n의 부호 값(음수 : -1 , 양수 : 1, 0 : 0)을 반환
   - POWER (b, e) : b의 e승 (b를 e번 거듭 곱한 값)
   - SQRT(n) : n의 평방근 값
   
  2) GREATST(n1, n2[,n3,....]), LEAST(n1, n2[,n3...])
   - 주어진 자료(n1, n2[,n3....]) 중 가장 큰 값(GREATEST) 또는 가장 작은 값(LEAST)를 반환
   -- 국어컬럼 수학컬럼 영어컬럼 등 여러 컬럼 중에서 큰 값 작은 값을 찾을 때에는 GREATST , LEAST를 반환
   -- 국어컬럼 내에서 큰 값 작은 값을 찾을 때에는 MAX , MIN 사용(정해진 그룹 내에서 사용)
   
 사용예) 
    SELECT GREATEST(10,20,30), LEAST(10,20,30),
           GREATEST('홍길동','홍길순','이순신'), 
           LEAST('홍길동', '홍길순', '이순신'), -- ㄱ,ㄴ,ㄷ 순으로 첫째 비교 다음으로 둘째 비교 ...
           GREATEST('GREAT','500','이순신'), -- 영문의 아스키코드와 500, 이순신의 아스키코드로 비교
           LEAST('GREAT', '500', '이순신'),
           --ASCII(500)--53
           --ASCII('이순신')--15506868
           --ASCII('GREAT')--71
    FROM DUAL;
    
 사용예) 회원테이블에서 마일리지가 1000 미만인 회원의 마일리지를 1000으로 부여하시오.
        Alias는 회원번호, 회원명, 원래마일리지, 새로운마일리지
        
        SELECT MEM_ID AS 회원번호,
                MEM_NAME AS 회원명,
                MEM_MILEAGE AS 원래마일리지,
               GREATEST(MEM_MILEAGE,1000) AS 새로운마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE < 1000;
        
 3) ROUND(n[, i]), TRUNC(n[, i])
  - 주어진 수 n 에서 소숫점 (i+1) 자리에서 반올림(ROUND), 자리버림(TRUNC) 을 수행한 결과를 반환
  - i 가 생략되면 0으로 간주
  - i 가 음수인 경우 정수부분에서 자리올림과 자리버림이 발생
 사용예)
        SELECT ROUND(123.345678,2), TRUNC(123.345678,2),
               ROUND(123.345678), TRUNC(123.345678),
               ROUND(123.345678,-2), TRUNC(123.345678,-2)
        FROM DUAL;
        
        
 사용예) 사원테이블에서 영업실적코드를 이용하여 보너스를 계산하고 지급액을 출력하시오.
        보너스 = 급여*영업실적코드의 27%
        세금 = (급여+보너스)의 13%
        지급액 = (급여+보너스) - 세금
        ** 모든 항목은 소수 첫째자리까지 출력할것.
        
        SELECT  EMPLOYEE_ID AS 사원번호,
                EMP_NAME AS 사원명,
                DEPARTMENT_ID AS 부서번호,
                COMMISSION_PCT AS 영업실적코드,
                SALARY AS 급여
                ROUND (SALARY * NVL(COMMISSION_PCT,0)*0.27,1) AS 보너스,
                ROUND ((SALARY * (SALARY*NVL(COMMISSION_PCT,0)*0.27))*0.13,1) AS 세금,
                ((SALARY * (SALARY*NVL(COMMISSION_PCT,0)*0.27))
                -((SALARY * (SALARY*NVL(COMMISSION_PCT,0)*0.27)*0.13),1) AS 지금액
        FROM HR.EMPLOYEES;
        
        
 4) FLOOT(n), CEIL(n)
  - FLOOR : n과 같거나 작은수 중 가장 큰수
  - CEIL : n과 같거나 큰수 중 가장 작은수
  
 사용예) SELECT FLOOR(20), FLOOR(20.7), FLOOR(-20.7),
               CEIL(20), CEIL(20.7), CEIL(-20.7)
        FROM DUAL;

 5)MOD(n,c), REMAINDER(n,c)
  - n을 c로 나눈 나머지를 반환함
  - MOD와 REMAINDER 는 내부에서 처리하는 방식이 다름
  - MOD 는 보통의 나머지 반환, REMAINDER 는 계산된 나머지가 젯수의 절반보다 크면 피젯수에서 다음 몫을 갖는 피제수를 뺀 값을 반환
  ex)
    MOD(10,7) : 10 - 7 * FLOOR(10/7)
              = 10 - 7 * FLOOR(1.428..)
              = 10 - 7 *
              = 3
    REMAINDER(10,7)
              = 10 - 7 * ROUND(10/7)
              = 10 - 7 * ROUND(1.428..)
              = 10 - 7 *
              = 3
              
    MOD(12,7) : 12 - 7 * FLOOR(12/7)
              = 12 - 7 * FLOOR(1.714..)
              = 12 - 7 * 1
              = 5
    REMAINDER(12,7)
              = 12 - 7 * ROUND(12/7)
              = 12 - 7 * ROUND(1.714..)
              = 12 - 7 * 2
              = -2
  
  SELECT MOD(10,7), REMAINDER(10,7), MOD(12,7), REMAINDER(12,7) FROM DUAL;
  -- 10/ 7 피제수와 제수
  
 사용예) 키보드로 연도를 입력 받아 해당년도가 윤년인지 평년인지 구별하시오.
        윤년 : 4의 배수면서 100의 배수가 아닌 해이거나 400의 배수가되는 해
        
        ACCEPT P_YEAR PROMT '년도입력 : '
        DECLARE
            V_YEAR NUMBER:=TO_NUMBER('&P_YEAR');
            V_RES VARCHAR2(255);
        BEGIN
            IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR (MOD(V_YEAR,400)=0) THEN
                V_RES:=V_YEAR||'년도는 윤년입니다!.';
            ELSE
                V_RES:=V_YEAR||'년도는 평년입니다!.';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(V_RES); --System.out.println() 의 기능
    END;
        
        
        
           
           