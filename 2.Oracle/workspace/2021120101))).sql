2021-1201-01)
 커서사용예) 2005년 4월 매입상품 중 수량기준으로 많이 매입된 3개 상품의 동 기간중 매출정보를 조회하시오.
            Alias는 상품코드, 상품명, 매출액
            
            
            SELECT A.BUY_PROD AS BID,
                   A.BSUM AS ABSUM
              FROM (SELECT BUY_PROD,
                           SUM(BUY_QTY) AS BSUM
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
                     GROUP BY BUY_PROD
                     ORDER BY 2 DESC) A
             WHERE ROWNUM <= 3;   
             
            --------------------------------------------------------------------------------------------------------
            (LOOP 사용) 
            DECLARE
              V_BID PROD.PROD_ID%TYPE;   --상품코드가 저장될 곳
              V_SUM NUMBER:=0; -- 매출금액
              V_BNAME PROD.PROD_NAME%TYPE;
              CURSOR CUR_BUYPROD
                IS
                SELECT A.BUY_PROD AS BID
                  FROM (SELECT BUY_PROD,
                               SUM(BUY_QTY) AS BSUM
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
                         GROUP BY BUY_PROD
                         ORDER BY 2 DESC) A
                 WHERE ROWNUM <= 3;
                 
              BEGIN    
                OPEN CUR_BUYPROD;
                
                LOOP
                  FETCH CUR_BUYPROD INTO V_BID;
                  EXIT WHEN CUR_BUYPROD%NOTFOUND;
                  SELECT SUM(B.CART_QTY * A.PROD_PRICE)
                    INTO V_SUM
                    FROM PROD A, CART B
                   WHERE A.PROD_ID = B.CART_PROD
                     AND B.CART_NO LIKE '200504%'
                     AND B.CART_PROD = V_BID;
              
              
             SELECT PROD_NAME INTO V_BNAME   -- 변수에 이름을 넣는 부분
               FROM PROD
              WHERE PROD_ID = V_BID;
              
              DBMS_OUTPUT.PUT_LINE('상품코드 : ' ||V_BID);
              DBMS_OUTPUT.PUT_LINE('상품명 : ' ||V_BNAME);
              DBMS_OUTPUT.PUT_LINE('매출액 : ' ||V_SUM);
               DBMS_OUTPUT.PUT_LINE('================================');
                END LOOP;
                
                CLOSE CUR_BUYPROD;
              END;
              
              
              
              
            (WHILE 사용)  
            DECLARE
              V_BID PROD.PROD_ID%TYPE;   --상품코드가 저장될 곳
              V_SUM NUMBER:=0; -- 매출금액
              V_BNAME PROD.PROD_NAME%TYPE;
              CURSOR CUR_BUYPROD
                IS
                SELECT A.BUY_PROD AS BID
                  FROM (SELECT BUY_PROD,
                               SUM(BUY_QTY) AS BSUM
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
                         GROUP BY BUY_PROD
                         ORDER BY 2 DESC) A
                 WHERE ROWNUM <= 3;
                 
              BEGIN    
                OPEN CUR_BUYPROD;
                FETCH CUR_BUYPROD INTO V_BID;               -- 패치를 하면서 자료가 있는지 없는 확인해야함.
                WHILE CUR_BUYPROD%FOUND LOOP
                  SELECT SUM(B.CART_QTY * A.PROD_PRICE)
                    INTO V_SUM
                    FROM PROD A, CART B
                   WHERE A.PROD_ID = B.CART_PROD
                     AND B.CART_NO LIKE '200504%'
                     AND B.CART_PROD = V_BID;
              
              
             SELECT PROD_NAME INTO V_BNAME   -- 변수에 이름을 넣는 부분
               FROM PROD
              WHERE PROD_ID = V_BID;
              
              DBMS_OUTPUT.PUT_LINE('상품코드 : ' ||V_BID);
              DBMS_OUTPUT.PUT_LINE('상품명 : ' ||V_BNAME);
              DBMS_OUTPUT.PUT_LINE('매출액 : ' ||V_SUM);
               DBMS_OUTPUT.PUT_LINE('================================');
                FETCH CUR_BUYPROD INTO V_BID;                -- FETCH.가 중복되면서 값이 징검다리로 읽히기 때문에 마지막에 기술해줌.
                END LOOP;
                
                CLOSE CUR_BUYPROD;
              END;
              
              
              
              
            (FOR 사용)  
            DECLARE
              V_SUM NUMBER:=0; -- 매출금액
              V_BNAME PROD.PROD_NAME%TYPE;
              CURSOR CUR_BUYPROD
                IS
                SELECT A.BUY_PROD AS BID
                  FROM (SELECT BUY_PROD,
                               SUM(BUY_QTY) AS BSUM
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
                         GROUP BY BUY_PROD
                         ORDER BY 2 DESC) A
                 WHERE ROWNUM <= 3;
                 
              BEGIN    
                FOR REC IN CUR_BUYPROD LOOP
                  SELECT SUM(B.CART_QTY * A.PROD_PRICE)
                    INTO V_SUM
                    FROM PROD A, CART B
                   WHERE A.PROD_ID = B.CART_PROD
                     AND B.CART_NO LIKE '200504%'
                     AND B.CART_PROD = REC.BID;
              
              
             SELECT PROD_NAME INTO V_BNAME   -- 변수에 이름을 넣는 부분
               FROM PROD
              WHERE PROD_ID = REC.BID;
              
              DBMS_OUTPUT.PUT_LINE('상품코드 : ' ||REC.BID);
              DBMS_OUTPUT.PUT_LINE('상품명 : ' ||V_BNAME);
              DBMS_OUTPUT.PUT_LINE('매출액 : ' ||V_SUM);
               DBMS_OUTPUT.PUT_LINE('================================');
                END LOOP;
                
              END;
              
              
              
              
              
            
            (FOR 사용- 커서생략)  
            DECLARE
              V_SUM NUMBER:=0; -- 매출금액
              V_BNAME PROD.PROD_NAME%TYPE;
                SELECT A.BUY_PROD AS BID
                  FROM (SELECT BUY_PROD,
                               SUM(BUY_QTY) AS BSUM
                          FROM BUYPROD
                         WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
                         GROUP BY BUY_PROD
                         ORDER BY 2 DESC) A
                 WHERE ROWNUM <= 3;
                 
              BEGIN    
                FOR REC IN  (SELECT A.BUY_PROD AS BID
                               FROM (SELECT BUY_PROD,
                                            SUM(BUY_QTY) AS BSUM
                                            FROM BUYPROD
                                            WHERE BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
                                            GROUP BY BUY_PROD
                                            ORDER BY 2 DESC) A
                               WHERE ROWNUM <= 3)
                    LOOP
                  SELECT SUM(B.CART_QTY * A.PROD_PRICE)
                    INTO V_SUM
                    FROM PROD A, CART B
                   WHERE A.PROD_ID = B.CART_PROD
                     AND B.CART_NO LIKE '200504%'
                     AND B.CART_PROD = REC.BID;
              
              
             SELECT PROD_NAME INTO V_BNAME   -- 변수에 이름을 넣는 부분
               FROM PROD
              WHERE PROD_ID = REC.BID;
              
              DBMS_OUTPUT.PUT_LINE('상품코드 : ' ||REC.BID);
              DBMS_OUTPUT.PUT_LINE('상품명 : ' ||V_BNAME);
              DBMS_OUTPUT.PUT_LINE('매출액 : ' ||V_SUM);
               DBMS_OUTPUT.PUT_LINE('================================');
                END LOOP;
                
              END;
            

            
 