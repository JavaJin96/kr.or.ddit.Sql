2021-1104-01)

  1) 숫자열 형
  . 실수 또는 정수를 저장하는 자료형
  . NUMBER 타입만 제공됨
  (사용형식)
  컬럼명 NUMBER[(*|정밀도[,스케일])]
  . '*|정밀도' : 전체 자릿수 (1~30사이 정수)
    '*'를 사용하면 시스템에게 자릿수 결정을 위임
  . '스케일' : 소숫점 이하의 자릿수
  . 표현범위 : 1.0 x E-130 ~9.9999... E+125(소수점이하'9'의 갯수 38개)
  . 자료의 저장
     - 스케일이 양수인 경우 : 저장하려는 자료의 소수점이하 (스케일 + 1) 자리에서 반올림하여 (스케일) 자릿수 만큼 저장.
     - 스케일이 음수인 경우 : 정수부분에서 (스케일) 위치의 정수 부분에서 반올림 (정수부분은 음수로 저장)
     - 21.1234567    NUMBER (7,4) = 21.1235
     - 12345.6789    NUMBER (7,-1) = 12350
                     NUMBER (7,-2) = 12300
    -- DB에서는 최대한 Data를 정확히 제공해야 하기에, 되도록 하지 않는 것이 좋다. 
    -- (반올림 같은 작업은 DB에서 받은 Data로 Java등에서 실행하면 된다.)
    
    . ex)
    -----------------------------------------------------------------------------
    타입선언              데이터                저장되는 값
    -----------------------------------------------------------------------------
    NUMBER              12345.9876            12345.9876
    NUMBER(*,3)         12345.9876            12345.988           --해당 Data를 저장할때의 최적의 장소를 찾음 * = 8
    NUMBER(4)           12345.9876            오류(2345,9876)                 --정수 부분의 자릿수가 부족하면 오류
    NUMBER(7,3)         12345.9876            오류(1234.9876)                 --정수 부분의 자릿수가 부족하면 오류
    NUMBER(10,2)        12345.9876               12345.99         --정수 자릿수가 8이므로 3개의 공백이 삽입
    NUMBER(7,0)         12345.9876              123456            --정수 자릿수가 7이므로 2개의 공백이 삽입
    NUMBER(7)           12345.9876              123456            --정수 자릿수가 7이므로 2개의 공백이 삽입
    -----------------------------------------------------------------------------
    
사용예)
    CREATE TABLE TEMP5(
    COL1 NUMBER,
    COL2 NUMBER(*,3),
    COL3 NUMBER(4),
    COL4 NUMBER(7,3),
    COL5 NUMBER(10,2),
    COL6 NUMBER(7,0),
    COL7 NUMBER(7)
    );
    
    INSERT INTO TEMP5
     VALUES(12345.9876,
            12345.9876,
            2345.9876,
            1234.9876,
            12345.9876,
            12345.9876,
            12345.9876);
     
     **정밀도 < 스케일
     . 정밀도는 '0'이 아닌 유효 숫자의 수
     . 스케일 : 소수점 이하의 자리수
     . 스케일 - 정밀도 : 소수점 이하에 맨 먼저 나와야 할 '0'의 개수
     ex)
     -------------------------------------------------------------------------
     입력 값             선언             기억되는 값
     -------------------------------------------------------------------------
     0.12345            NUMBER(3,5)     오류
     0.012345           NUMBER(4,5)     0.01235    
     0.0012345          NUMBER(3,5)     0.00123
     1.23               NUMBER(1,3)     오류
     0.012              NUMBER(2,5)     오류
     -------------------------------------------------------------------------
    
    
    
    
    
    
    
    
    
    
                     