2021-1130-04)반복문과 커서
 1) 반복문 
  - 프로그래밍언어의 반복문의 역활과 동일
  - LOOP,WHILE,FOR문 제공
  1) LOOP 문
   -무한루프 제공
   -반복문의 기본구조 제공

    (사용형식)
     LOOP
        반복명령문(들)ㅣ
        [EXIT THEN 조건;]
     END LOOP;
      - 'EXIT WHEN 조건' : 조건이 참인 경우 반복을 벗어남
      
사용예) 구구단의 7단을 출력하시오.
    DECLARE 
      V_CNT NUMBER:=1;
      V_SUM NUMBER:=0;
    BEGIN
     LOOP
       V_SUM:=7*V_CNT;
       EXIT WHEN V_CNT>9;
       DBMS_OUTPUT.PUT_LINE(7||'*'||V_CNT||'='||V_SUM);
       V_CNT:=V_CNT+1;
       END LOOP;
    END;
    
    사용예2_ 백원으로 시작하여 매일 2배의 돈을 저금할때 몇일 후에 100만원이 되는지 계산하시오.
    DECLARE
     V_SUM NUMBER :=100;
     V_CNTDAY NUMBER :=0;
    BEGIN
     LOOP
        EXIT WHEN V_SUM >=1000000;
        V_SUM:=V_SUM*2;
        V_CNTDAY:=V_CNTDAY+1;
     END LOOP;
     DBMS_OUTPUT.PUT_LINE('100만원 모으기 까지 걸린날짜: '||V_CNTDAY||'일');
     DBMS_OUTPUT.PUT_LINE('저금한 돈: '||V_SUM||'원');
    END;
 
 2) WHILE 반복문 
  . CURSOR변수 혹은 FOR문과 비교했을때 비효율 적이라 잘 안쓴다.
  . 조건판단 후 반복 수행
  . 반복횟수가 중요하지 않거나 횟수를 알지 못할때
  . 반복을 벗어나는 탈출조건을 알고 있을때
    (사용형식)
    WHILE 조건 LOOP
      반복처리문(들);
      
      
    END LOOP;
     - 조건이 참이면 반복수행, 거짓이면 반복을 종료함
     
     사용예1_위 예제들을 WHILE 문으로 변경하시오.
     
     DECLARE 
      V_CNT NUMBER :=1;
      V_SUM NUMBER :=0;
     BEGIN
        WHILE (V_CNT<9) LOOP
        V_SUM:= 7*V_CNT;
        DBMS_OUTPUT.PUT_LINE('7*'||V_CNT||'='||V_SUM);
        V_CNT:=V_CNT+1;
        END LOOP;
     END;
     
     --두번째 예재 WHILE 문으로:
  
  2) FOR 문
   . 커서용 FOR문과 일반 FOR문이 따로있다. 
   . 반복횟수가 중요하거나 반복횟수를 정확히 알고있는 경우
    
    2-1(일반적 FOR문의 사용형식)
     FOR 인덱스 IN [REVERSE] 초기값..최종값 LOOP
      반복처리명령문(들);
     END LOOP;
     . 인덱스 : 초기값부터 최종값을 보관할 기억공간을 시스템에서 확보해줌
     . 초기값..최종값 : 초기값부터 최종값까지 1씩 증가
     
     사용예1) 
     구구단의 7단
     DECLARE 
       V_SUM NUMBER:=0;
     BEGIN
       FOR I IN 1..9 LOOP
         V_SUM:=7*I;
         DBMS_OUTPUT.PUT_LINE('7*'||I||'='||V_SUM);
       END LOOP;
     END;
     
   2-2(커서용 FOR문의 사용형식)
      FOR 레코드 IN 커서이름|커서용 SELECT문 LOOP
        처리명령문(들);
      END LOOP;
      .커서컬럼 참조는 '레코드.커서컬럼명'
    