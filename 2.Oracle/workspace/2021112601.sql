2021-1126-01)

 ��뿹) 2005�� 1�� ��ǰ�� �԰������ ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�.
        ��¥�� 2005�� 1�� 31���̴�.
        
        
        (�������� : 2005�� 1�� ��ǰ�� �԰��������)
        SELECT  BUY_PROD AS ��ǰ,
                SUM(BUY_QTY) AS �԰���� 
          FROM BUYPROD
         WHERE BUY_DATE BETWEEN ('20050101') AND ('20050131')
         GROUP BY BUY_PROD
         ORDER BY 1;
          
        (�������� : ����)
        UPDATE REMAIN A
           SET (A.REMAIN_I, A.REMAIN_J_99, A.REMAIN_DATE) =
              (SELECT A.REMAIN_I + B.BSUM,
                      A.REMAIN_J_99 + B.BSUM,
                      TO_DATE('20050131') 
               FROM (SELECT  BUY_PROD AS,
                            SUM(BUY_QTY) AS BSUM 
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN ('20050101') AND ('20050131')
                     GROUP BY BUY_PROD) B
              WHERE B.BUY_PROD = A.PROD_ID)       
         WHERE REMAIN_YEAR  = '2005'
           AND A.PROD_ID IN (SELECT DISTINCT BUY_PROD
                               FROM BUYPROD
                              WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131'));
        
        COMMIT;
        
        
 ��뿹) 2005�� 4�� �������踦 ��ȸ�Ͽ� ���������̺��� �����Ͻÿ�.--(�̷��� �����ϴ� ����� ���Ǿ���)
    (SELECT CART_PROD AS �����ǰ,
           SUM(CART_QTY) AS ����
      FROM CART
      WHERE CART_NO LIKE('200504%')
      GROUP BY CART_PROD)
      
      UPDATE REMAIN A
         SET (A.REMAIN_O,A.REMAIN_J_99,A.REMAIN_DATE)=
           (SELECT A.REMAIN_O+B.CSUM, A.REMAIN_J_99-B.CSUM, TO_DATE('20050430')
              FROM(SELECT CART_PROD AS CID,
                          SUM(CART_QTY) AS CSUM
                     FROM CART
                    WHERE CART_NO LIKE ('200504%')
                    GROUP BY CART_PROD)B
             WHERE B.CID = A.PROD_ID)
       WHERE A.REMAIN_YEAR ='2005'
         AND A.PROD_ID IN(SELECT DISTINCT CART_PROD
                            FROM CART
                            WHERE CART_NO LIKE ('200504%'));
        